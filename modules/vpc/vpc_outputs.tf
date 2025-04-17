output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "public_subnet_id" {
  value = aws_subnet.main_vpc_public_subnet.id
}

output "vpc_ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

# output "private_subnet_id" {
#   value = aws_subnet.subnet2.id
# }