module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id1
  ec2_ami = var.ec2_ami
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
}
