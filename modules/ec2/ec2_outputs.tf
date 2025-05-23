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
