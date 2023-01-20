locals {
  s3_bucket_name = "${var.project_name}-project-${var.bucket_name}"
}

# KMS Encryption Key
resource "aws_kms_key" "s3_bucket_encryption_key" {
  description             = "Used for encryption of s3 bucket objects"
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  tags                    = {
    Name = "${var.project_name}-s3-bucket-encryption-key"
  }
}

resource "aws_kms_alias" "s3_bucket_encryption_key_alias" {
  name          = "alias/${var.project_name}-s3-bucket-encryption-key"
  target_key_id = aws_kms_key.s3_bucket_encryption_key.arn
}

# S3 Bucket & Infra
resource "aws_s3_bucket" "bucket" {
  bucket = local.s3_bucket_name

  tags = {
    Name = local.s3_bucket_name
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.bucket_versioning_status
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_bucket_encryption_key.arn
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  count = var.create_120_days_bucket_lifecycle ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  rule {
    id = "delete-all-files-in-bucket-120-days-rule"
    filter {}
    expiration {
      days = 120
    }
    status = var.lifecycle_rule_status
  }
}
