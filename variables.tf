variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "phoenix"
}

variable "optional_crawler_cron_schedule" {
  description = "Cron expression to switch on scheduled crawler execution"
  type        = string
  default     = "cron(35 11 * * ? *)"
}
