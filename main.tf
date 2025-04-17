module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
}

# module "ec2" {
#   source = "./modules/ec2"
#   vpc_id = module.vpc.vpc_id
#   subnet_ids = module.vpc.subnet_ids
# }

# module "s3" {
#   source = "./modules/s3"
#   bucket_name = var.s3_bucket_name
# }