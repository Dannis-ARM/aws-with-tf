terraform {
  backend "s3" {
    bucket         = "terraform-state-462096170731"
    key            = "terraform/state"
    region         = "us-west-1"
    dynamodb_table = "terraform-lock"
  }
}