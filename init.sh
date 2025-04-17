export TF_VAR_bucket_name="terraform-state-462096170731"
export TF_VAR_key_name="terraform/state"
export TF_VAR_region="us-east-1"
export TF_VAR_dynamodb_table="terraform-lock"

deployRegion=us-west-1

aws s3api create-bucket \
  --bucket terraform-state \
  --region $TF_VAR_region \
  --create-bucket-configuration LocationConstraint=$TF_VAR_region

aws dynamodb create-table \
    --table-name $TF_VAR_dynamodb_table \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $TF_VAR_region