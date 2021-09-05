provider aws {
  region = "ap-northeast-1"
}

data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_vpc" "push_ecr" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {"Name" = "push_ecr"}
}

resource "aws_subnet" "push_ecr" {
  vpc_id = aws_vpc.push_ecr.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  tags = {Name = "push_ecr"}
}

resource "aws_internet_gateway" "push_ecr" {
  vpc_id = aws_vpc.push_ecr.id
  tags = {Name = "push_ecr"}
}

resource "aws_route_table" "push_ecr" {
    vpc_id = aws_vpc.push_ecr.id
    tags = {Name = "push_ecr"}
}

resource "aws_route" "push_ecr" {
  route_table_id = aws_route_table.push_ecr.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.push_ecr.id
  depends_on = [aws_route_table.push_ecr]
}

resource "aws_route_table_association" "push_ecr" {
    subnet_id = aws_subnet.push_ecr.id
    route_table_id = aws_route_table.push_ecr.id
}

resource "aws_security_group" "push_ecr" {
  name        = "push_ecr"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.push_ecr.id

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

resource "aws_security_group_rule" "inbound_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.push_ecr.id
}

data "aws_iam_policy_document" "push_ecr" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "push_ecr" {
  name               = "push_ecr"
  assume_role_policy = data.aws_iam_policy_document.push_ecr.json
}

resource "aws_iam_role_policy_attachment" "push_ecr" {
  role       = aws_iam_role.push_ecr.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_instance_profile" "push_ecr" {
  name = "push_ecr"
  role = aws_iam_role.push_ecr.name
}

resource "aws_ecr_repository" "wordpress" {
  name = "wordpress"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}


resource "aws_instance" "myAmazonLinux2" {
    ami = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t2.micro"
    user_data = file("userdata.sh")
    tags = {"Name" = "push_ecr"}
    key_name = "test"
    vpc_security_group_ids = [aws_security_group.push_ecr.id]
    subnet_id = aws_subnet.push_ecr.id
    associate_public_ip_address = "true"
    iam_instance_profile = aws_iam_instance_profile.push_ecr.name
}