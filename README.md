# Project Description
This is project aws-with-tf

### For Windows
# Pre-requista
:Install Aws Cli
set HTTPS_PROXY=http://localhost:7890
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn

Install Terraform
Find 386 version from https://developer.hashicorp.com/terraform/install

### For Linux 
```bash
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

# Deployment Guide 

### if you are first time to use 
source before_init.sh

### else
touch terraform.tfvars

```tfvars
aws_region       = "us-west-1"
vpc_cidr         = "10.0.0.0/16"
vpc_pub_sub_cidr = "10.0.1.0/24"
s3_bucket_name   = "general-bucket-462096170731"
ec2_ami          = "ami-0c403204e8d09eca0"
ec2_key_name     = "skylab-ec2"
```
