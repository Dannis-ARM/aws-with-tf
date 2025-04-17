#!/bin/bash

script_dir=`dirname $(realpath $0)` && cd $script_dir

# Initialize Terraform
terraform init

# Apply Terraform configuration
terraform apply -auto-approve