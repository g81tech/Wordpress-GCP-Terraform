terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.key_access_json)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

##################################################################
# Criação de uma rede
resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

##################################################################
# Reserva de um endereço IP estático
resource "google_compute_address" "static_ip" {
  name   = var.ip_name
  region = var.region
}

##################################################################
# Criação de uma instância
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # imagem Debian  11
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.user_instance}:$(cat ${path.module}/${var.key_access_name}"
  }

  tags = ["webserver"]

  # Criação de um script de inicialização
  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo apt install git
  EOF
}

##################################################################
# Criação de uma regra de firewall
resource "google_compute_firewall" "terraform-network" {
  name    = "default-allow-http-https"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["webserver"]
  depends_on    = [google_compute_network.vpc_network]

}

##################################################################
# Saída do endereço IP estático
output "static_ip_address" {
  value       = google_compute_address.static_ip.address
  description = "The static IP address reserved for the instance."
}
