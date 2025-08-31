module "awd_prd" {
  source = "../../infra"
  instance_type = "t3.micro"
  key_ssh = "IaC-PRD"
  ami_id = "ami-0360c520857e3138f"
  region_aws = "us-east-1"
}

output "public_ip_prd" {
  value = module.awd_dev.public_ip
}