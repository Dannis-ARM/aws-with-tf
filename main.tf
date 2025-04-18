module "scripts" {
  source = "./modules/scripts"
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_pub_sub_cidr = var.vpc_pub_sub_cidr
  my_public_ip     = module.scripts.my_public_ip
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  vpc_ssh_sg_id = module.vpc.vpc_ssh_sg_id
  ec2_ami       = var.ec2_ami
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}
