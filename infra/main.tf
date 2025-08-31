terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.regiao_aws
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.tipo_instancia
  key_name = var.chave_ssh
  tags = {
    Name = "Terraform Ansible Ruby on Rails"
  }
}

resource "aws_key_pair" "keySSH" {
	key_name   = var.chave_ssh
	public_key = file("${var.chave_ssh}.pub")
}