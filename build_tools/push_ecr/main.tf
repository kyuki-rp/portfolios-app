
variable "app_name" {}
variable "aws_account_id" {}

provider "aws" {
  region = "ap-northeast-1"
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_ecr_repository" "wordpress" {
  name = "wordpress"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}

module "iam" {
  source      = "../iam"
  name        = var.app_name
}

module "network" {
  source = "./network"
  app_name = var.app_name
}

resource "aws_instance" "default" {
    ami = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t2.micro"
    user_data = templatefile("userdata.sh", {aws_account_id=var.aws_account_id, region_name="ap-northeast-1"})
    key_name = "test"
    tags = {"Name" = "${var.app_name}_push_ecr"}
    vpc_security_group_ids = [aws_security_group.default.id]
    subnet_id = aws_subnet.default.id
    associate_public_ip_address = "true"
    iam_instance_profile = module.iam.aws_iam_instance_profile_name
}