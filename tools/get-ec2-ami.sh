function get_ami {
    region=$1

    aws ec2 describe-images \
        --owners amazon \
        --filters "Name=name,Values=amzn2-ami-hvm-2.0.2023*-x86_64-gp2" \
        --query 'sort_by(Images, &CreationDate)[-1].ImageId' \
        --region $region \
        --output text
}

get_ami $1
