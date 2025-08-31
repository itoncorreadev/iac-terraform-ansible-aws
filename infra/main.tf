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
  region  = var.region_aws
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_ssh
  tags = {
    Name = "Terraform Ansible Ruby on Rails"
  }
  depends_on = [
    aws_key_pair.key_pair
  ]
}

resource "aws_key_pair" "key_pair" {
	key_name   = var.key_ssh
	public_key = file("${var.key_ssh}.pub")
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}