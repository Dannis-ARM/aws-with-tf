variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID for ec2"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "vpc_pub_sub_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "ec2_key_name" {
  description = "The name of the AWS Key Pair to use"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
}
