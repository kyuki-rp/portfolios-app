variable "name" {}
variable "vpc_id" {}

resource "aws_internet_gateway" "default" {
  vpc_id = var.vpc_id
  tags = {Name = var.name}
}

resource "aws_route_table" "default" {
    vpc_id = var.vpc_id
    tags = {Name = var.name}
}

resource "aws_route" "default" {
  route_table_id = aws_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default.id
  depends_on = [aws_route_table.default]
}

output "id" {
  value = aws_route_table.default.id
}