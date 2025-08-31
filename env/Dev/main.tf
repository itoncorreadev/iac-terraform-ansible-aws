module "awd_dev" {
  source = "../../infra"
  tipo_instancia = "t3.micro"
  chave_ssh = "IaC-DEV"
  ami_id = "ami-0360c520857e3138f"
  regiao_aws = "us-east-1"
}