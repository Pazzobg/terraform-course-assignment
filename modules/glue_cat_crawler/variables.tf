variable "project_name" {
  description = "(Required) Name of the project."
  type        = string
}

variable "database_name" {
  description = "(Required) Glue database where results are written."
  type        = string
}

variable "crawler_name" {
  description = "(Required) Name of the crawler."
  type        = string
}

variable "crawler_target_bucket" {
  description = "(Required) Name of the S3 target bucket."
  type        = string
}

variable "target_bucket_kms_key_arn" {
  description = "(Required) ARN of the KMS key used for target bucket encryption."
  type        = string
}

variable "crawler_schedule" {
  description = "(Optional) A cron expression used to specify the schedule."
  type        = string
  default     = null
}
