locals {
  iam_policy_name   = "${var.crawler_name}-iam-policy"
  iam_role_name     = "${var.crawler_name}-iam-role"
  crawler_full_name = "${var.project_name}-${var.crawler_name}"
}

data "aws_caller_identity" "current" {}

# Create crawler IAM permissions
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["glue.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "crawler_iam_role" {
  name               = local.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = {
    Name = local.iam_role_name
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.crawler_target_bucket}",
      "arn:aws:s3:::${var.crawler_target_bucket}/MAPPING_DATA/*"
    ]
  }

  statement {
    effect  = "Allow"
    actions = [
      "glue:*Database*",
      "glue:*Table*",
      "glue:*Crawler*",
      "glue:*Classifier*"
    ]
    resources = [
      "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:catalog",
      "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:database/*",
      "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:table/*",
      "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:crawler/*",
      "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:userDefinedFunction/*/*"
    ]
  }

  statement {
    effect  = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt"
    ]
    resources = [
      var.target_bucket_kms_key_arn
    ]
  }

  statement {
    effect  = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*",
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*"
    ]
  }
}

resource "aws_iam_policy" "crawler_iam_policy" {
  name   = local.iam_policy_name
  policy = data.aws_iam_policy_document.this.json
  tags   = {
    Name = local.iam_policy_name
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.crawler_iam_role.name
  policy_arn = aws_iam_policy.crawler_iam_policy.arn
}

# Create Glue crawler
resource "aws_glue_crawler" "this" {
  database_name = var.database_name
  name          = local.crawler_full_name
  schedule      = var.crawler_schedule
  role          = aws_iam_role.crawler_iam_role.arn

  s3_target {
    path = "s3://${var.crawler_target_bucket}/MAPPING_DATA/"
  }

  tags = {
    Name = local.crawler_full_name
  }
}
