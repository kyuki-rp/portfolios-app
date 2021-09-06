
variable "app_name" {}
variable "aws_account_id" {}

provider "aws" {
  region = "ap-northeast-1"
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {"Name" = "${var.app_name}_push_ecr"}
}

resource "aws_subnet" "default" {
  vpc_id = aws_vpc.default.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  tags = {Name = "${var.app_name}_push_ecr"}
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {Name = "${var.app_name}_push_ecr"}
}

resource "aws_route_table" "default" {
    vpc_id = aws_vpc.default.id
    tags = {Name = "${var.app_name}_push_ecr"}
}

resource "aws_route" "default" {
  route_table_id = aws_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default.id
  depends_on = [aws_route_table.default]
}

resource "aws_route_table_association" "default" {
    subnet_id = aws_subnet.default.id
    route_table_id = aws_route_table.default.id
}

resource "aws_security_group" "default" {
  name        = "${var.app_name}_push_ecr"
  description = "Used in the terraform"
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

resource "aws_security_group_rule" "default" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.default.id
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "default" {
  name               = "${var.app_name}_push_ecr"
  assume_role_policy = data.aws_iam_policy_document.default.json
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_instance_profile" "default" {
  name = "${var.app_name}_push_ecr"
  role = aws_iam_role.default.name
}

resource "aws_ecr_repository" "wordpress" {
  name = "wordpress"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
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
    iam_instance_profile = aws_iam_instance_profile.default.name
}