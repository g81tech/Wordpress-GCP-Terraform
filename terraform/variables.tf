variable "key_access_json" {
  type      = string
  sensitive = true
}

variable "project_id" {
  type      = string
  sensitive = true
}

variable "region" {
  type      = string
  sensitive = true
}

variable "zone" {
  type      = string
  sensitive = true
}

variable "key_access_name" {
  type      = string
  sensitive = true
}

variable "user_instance" {
  type      = string
  sensitive = true
}

################# names
variable "network_name" {
  type      = string
  sensitive = true
}

variable "ip_name" {
  type      = string
  sensitive = true
}

variable "instance_name" {
  type      = string
  sensitive = true
}
