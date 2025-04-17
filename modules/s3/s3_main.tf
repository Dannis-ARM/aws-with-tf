resource "aws_s3_bucket" "general_bucket" {
  bucket = var.bucket_name
}

output "bucket_arn" {
  value = aws_s3_bucket.general_bucket.arn
}
