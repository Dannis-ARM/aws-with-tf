variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of one subnet"
  type        = string
}

variable "ec2_ami" {
  description = "ec2_ami"
  type        = string
}

variable "vpc_ssh_sg_id" {
  description = "ID of the security group"
  type        = string
}