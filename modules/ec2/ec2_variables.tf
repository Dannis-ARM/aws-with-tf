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

variable "ec2_key_name" {
  description = "The name of the AWS Key Pair to use"
  type        = string
}

variable "my_public_ip" {
}
