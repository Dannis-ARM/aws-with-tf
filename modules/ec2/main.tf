resource "aws_instance" "general_ec2" {
  ami           = var.ec2_ami
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = "general-ec2"
  }
}

output "instance_id" {
  value = aws_instance.general_ec2.id
}