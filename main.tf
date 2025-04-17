module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_pub_sub_cidr = var.vpc_pub_sub_cidr
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  ec2_ami = var.ec2_ami
  vpc_ssh_sg_id = module.vpc.vpc_ssh_sg_id
  # subnet_id = module.vpc.private_subnet_id
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
}
