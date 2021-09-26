
variable "app_name" {}
variable "aws_account_id" {}

resource "aws_ecr_repository" "wordpress" {
  name = "wordpress"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}

resource "aws_ecr_repository" "traefik" {
  name = "traefik"
}

module "iam" {
  source      = "./iam"
  name        = var.app_name
}

module "network" {
  source = "./network"
  name = var.app_name
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "default" {
    ami = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t2.micro"
    user_data = templatefile("userdata.sh", {aws_account_id=var.aws_account_id, region_name="ap-northeast-1"})
    key_name = "test"
    tags = {"Name" = var.app_name}
    vpc_security_group_ids = [module.network.aws_security_group_id]
    subnet_id = module.network.aws_subnet_id
    associate_public_ip_address = "true"
    iam_instance_profile = module.iam.aws_iam_instance_profile_name
}