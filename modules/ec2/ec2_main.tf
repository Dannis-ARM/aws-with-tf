resource "aws_instance" "general_ec2" {
  ami                         = var.ec2_ami
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  security_groups             = [var.ec2_sg_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-keypair.key_name

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
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

output "instance_public_dns" {
  value = aws_instance.general_ec2.public_dns # 添加输出公共 DNS 名称
}

output "ssh_command" {
  value     = "ssh -i ${pathexpand("~/")}\\.ssh\\${var.ec2_key_name} ec2-user@${aws_instance.general_ec2.public_dns}"
  sensitive = true
}
