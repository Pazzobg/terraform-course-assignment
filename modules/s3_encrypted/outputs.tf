# KMS Outputs
output "s3_bucket_encryption_key_arn" {
  value = aws_kms_key.s3_bucket_encryption_key.arn
}

output "s3_bucket_encryption_key_id" {
  value = aws_kms_key.s3_bucket_encryption_key.key_id
}

output "s3_bucket_encryption_key_alias_name" {
  value = aws_kms_alias.s3_bucket_encryption_key_alias.name
}

output "s3_bucket_encryption_key_alias_arn" {
  value = aws_kms_alias.s3_bucket_encryption_key_alias.arn
}

output "s3_bucket_encryption_key_alias_target_key_arn" {
  value = aws_kms_alias.s3_bucket_encryption_key_alias.target_key_arn
}

# S3 Outputs
output "s3_bucket_all" {
  value = aws_s3_bucket.bucket
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}
