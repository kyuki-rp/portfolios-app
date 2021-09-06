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
  tags = {Name = var.app_name}
}

module "igw" {
  source      = "../igw"
  name        = "${var.app_name}"
  vpc_id      = aws_vpc.default.id
}

resource "aws_security_group" "default" {
  name        = var.app_name
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "aws_subnet" {
    value = aws_subnet.default
}

output "aws_security_group" {
    value = aws_security_group.default
}
