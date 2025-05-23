module "scripts" {
  source = "./modules/scripts"
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_pub_sub_cidr = var.vpc_pub_sub_cidr
}

module "ec2" {
  source       = "./modules/ec2"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  ec2_ami      = var.ec2_ami
  ec2_key_name = var.ec2_key_name
  my_public_ip = module.scripts.my_public_ip
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "ecs" {
  source         = "./modules/ecs"
  ecs_vpc_id     = module.vpc.vpc_id
  ecs_subnet_id  = module.vpc.public_subnet_id
  ecs_subnet_ids = module.vpc.vpc_subnet_ids
  my_public_ip   = module.scripts.my_public_ip
  aws_region     = var.aws_region
}

