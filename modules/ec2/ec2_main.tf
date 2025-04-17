resource "aws_instance" "general_ec2" {
  ami           = var.ec2_ami
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  security_groups = [var.vpc_ssh_sg_id]
  associate_public_ip_address = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "general-ec2"
  }
}

output "instance_id" {
  value = aws_instance.general_ec2.id
}

output "instance_public_ip" {
  value = aws_instance.general_ec2.public_ip
}