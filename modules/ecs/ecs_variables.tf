variable "ecs_vpc_id" {}

variable "ecs_subnet_id" {}

variable "ecs_subnet_ids" {}

variable "my_public_ip" {
  description = "My public IP address"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}
