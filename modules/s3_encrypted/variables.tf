# General Variables
variable "project_name" {
  description = "(Required) Name of the project."
  type        = string
}

# KMS Variables
variable "kms_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  type        = number
  default     = 30
}

# S3 Variables
variable "bucket_name" {
  description = "(Required) Name of the bucket."
  type        = string
}

variable "bucket_versioning_status" {
  description = "The versioning state of the bucket. Valid values: Enabled, Suspended, or Disabled."
  type        = string
  default     = "Enabled"
}

variable "create_120_days_bucket_lifecycle" {
  description = "A Boolean whether to create a lifecycle rule over the bucket or not."
  type        = bool
  default     = false
}

variable "lifecycle_rule_status" {
  description = "Whether the rule is currently being applied. Valid values: Enabled or Disabled."
  type        = string
  default     = "Enabled"
}
