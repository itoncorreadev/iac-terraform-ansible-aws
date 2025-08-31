# ☁️ Infraestrutura AWS com Terraform e Ansible (Ruby on Rails)

Este repositório contém a configuração de infraestrutura como código (IaC) utilizando **Terraform** para provisionar recursos na AWS e **Ansible** para automatizar a configuração das instâncias.

## 🛠 Tecnologias Utilizadas

- 🌀 **Terraform**: Criação de recursos AWS (EC2, Key Pairs, Security Groups, etc.)  
- ⚡ **Ansible**: Provisionamento e configuração de aplicações nas instâncias EC2  
- ☁️ **AWS**: Serviços utilizados: EC2, Key Pair, Security Groups, VPC padrão  
- 🔐 **SSH**: Para acessar as instâncias e aplicar o Ansible  

## 📂 Estrutura do Repositório

```bash
├── 📂 env/
│   ├── 📂 dev/
│   │   ├── 🌀 main.tf
│   │   └── ⚡ playbook.yml
│   └── 📂 prd/
│   │   ├── 🌀 main.tf
│   │   └── ⚡ playbook.yml
│   └── 📂 group_vars/
│       └── ⚡ all.yml
├── 📂 infra/
│   ├── ⚡ hosts.yml
│   ├── 🌀 main.tf
│   ├── 🌀 variables.tf
│   └── 🌀 security_group.tf
└── 📄 README.md
```

## ⚙️ Pré-requisitos

- ✅ **Terraform** >= 1.0  
- ✅ **AWS CLI** configurada com credenciais válidas  
- ✅ **Ansible** >= 2.9  
- ✅ **Chave SSH privada** correspondente à key pair utilizada no Terraform  

## 🚀 Como Provisionar a Infraestrutura

### 1️⃣ Configurar AWS CLI
```bash
aws configure
```

Forneça:

- AWS Access Key ID
- AWS Secret Access Key
- Default region (ex: us-east-1)
- Default output format (json)

### 2️⃣ Inicializar Terraform

```bash
cd infra
terraform init

cd env/dev
terraform init
```

### 3️⃣ Planejar a criação dos recursos

```bash
terraform plan
```

### 4️⃣ Aplicar a infraestrutura

```bash
terraform apply
```

### 5️⃣ Verificar IP das instâncias

```bash
terraform output app_server_public_ip
```

## 🔐 Conectar via SSH

```bash
ssh -i "env/dev/IaC-DEV.pem" ubuntu@<IP_PUBLICO_DA_INSTANCIA>
```
Substitua <IP_PUBLICO_DA_INSTANCIA> pelo IP retornado pelo Terraform.
Use o usuário correto conforme a AMI:

- Ubuntu → ubuntu

- Amazon Linux → ec2-user

## 🖥 Provisionamento com Ansible

### 1️⃣ Atualize o inventário (hosts.yml) com o IP público da instância:

### 2️⃣ Execute o playbook:

```bash
ansible-playbook env/dev/playbook.yml -i infra/hosts.yml -u ubuntu --private-key env/dev/IaC-DEV.pem
```

## 📊 Arquitetura da Infraestrutura

```bash
          ┌───────────────┐
          │ Terraform     │
          │ Provisiona:   │
          │ - VPC         │
          │ - SG          │
          │ - EC2         │
          │ - Key Pair    │
          └───────┬───────┘
                  │
                  ▼
          ┌───────────────┐
          │ AWS EC2       │
          │ Instâncias    │
          │ Ubuntu / AMI  │
          └───────┬───────┘
                  │
                  ▼
          ┌───────────────┐
          │ Ansible       │
          │ Configura:    │
          │ - Apps        │
          │ - Pacotes     │
          │ - Users/SSH   │
          └───────────────┘

```

## 💡 Dicas e Boas Práticas

- Sempre rode terraform plan antes de terraform apply.
- Proteja sua chave privada:

```bash
chmod 400 IaC-DEV
```
- Para destruir a infraestrutura criada:

```bash
terraform destroy
```
- Mantenha o inventário Ansible atualizado com os IPs das instâncias.

- Use Security Groups da AWS para permitir acesso à porta 22 (SSH).