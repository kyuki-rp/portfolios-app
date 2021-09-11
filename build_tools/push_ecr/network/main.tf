variable "app_name" {}

resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {"Name" = var.app_name}
}

resource "aws_subnet" "default" {
  vpc_id = aws_vpc.default.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  tags = {"Name" = var.app_name}
}

module "igw" {
  source      = "../igw"
  name        = var.app_name
  vpc_id      = aws_vpc.default.id
  subnet_id   = aws_subnet.default.id
}

module "sg" {
  source      = "../sg"
  name        = var.app_name
  vpc_id      = aws_vpc.default.id
}

output "aws_subnet_id" {
    value = aws_subnet.default.id
}

output "aws_security_group_id" {
    value = module.sg.id
}
