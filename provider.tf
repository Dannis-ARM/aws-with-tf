variable "deploy_region" {
  description = "The AWS region where the S3 bucket and DynamoDB table are located"
  type        = string
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}

provider "aws" {
  region = var.deploy_region
}