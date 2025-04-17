resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "subnet_id1" {
  value = aws_subnet.subnet1.id
}

output "subnet_id2" {
  value = aws_subnet.subnet2.id
}