# Instalação dentro do nível gratuito

- ## Crie uma conta no GCP

```
- https://cloud.google.com/?hl=pt-BR
- Acesse o console e vá em APIs e serviços
- Clique em: Enable APIs and Services (Habilitar APIs e serviços)
- Procure por Compute Engine API e ative-a caso ainda não esteja
```

- ## Crie um novo projeto

```
- Acesse para criar um novo projeto: https://console.cloud.google.com/projectcreate
- Após, pesquise por credenciais, clique em Criar e depois em Conta de serviço
- Preencha o nome e avance, em "Conceda a essa conta de serviço acesso ao projeto" atribua o papel de: Editor e conclua
- Clique na conta de serviço que acabou de criar e clique em chaves
- Adicione uma nova chave criando uma nova json e salve na pasta terraform. PS: O nome da chave com o .json você vai usar na variável de ambiente posteriormente.
```

- ## Dentro da pasta terraform gere uma chave ssh

  `Ex: ssh-keygen -t rsa -b 4096`

- ## Crie um arquivo chamado exatamente `secrets.tfvars` na pasta terrafom. Nele informe as variáveis:

```
key_access_json = "nome da credencial.json de acesso ao GCP"
project_id      = "nome do seu projeto"
region          = "região que será criada no gcp. Ex: southamerica-east1"
zone            = "zona referente a região. Ex: southamerica-east1-c"
key_access_name = "nome da chave ssh publica criada."
network_name    = "nome da rede que será criado no gcp"
ip_name         = "nome identificador do ip estático"
instance_name   = "nome identificador da instância"
user_instance   = "nome do seu usuário"
```

- ## Crie um arquivo chamado .env na raiz do projeto

```
MYSQL_ROOT_PASSWORD= Sua senha root do banco de dados
MYSQL_USER= Usuário do banco de dados
MYSQL_PASSWORD= Senha do banco de dados
MYSQL_DB= Nome do banco de dados
MY_DOMAIN= O domínio de seu site
```

- ## Execute local com o Docker
  Lembre-se de instalar o <a href="https://docs.docker.com/engine/install/" target="_blank" />Docker</a>

```
docker compose up -d
```

- ## Deploy para o GCP
  Lembre-se de instalar o <a href="https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli" target="_blank" />Terraform</a>

```
- Navegue para a pasta do terraform
- Dê o comando terraform init para iniciar o terraform
- em seguida, terraform plan para preparar para o deploy
- e terraform apply -auto-approve -var-file="secrets.tfvars" para fazer o deploy no GCP
- Lembre-se de criar um registro A em seu gerenciador de domínio apontando para o IP estático de sua aplicação.
```
