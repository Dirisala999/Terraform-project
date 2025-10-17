variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group to monitor"
  type        = string
}

variable "email_address" {
  description = "Email address for alarm notifications"
  type        = string
}
