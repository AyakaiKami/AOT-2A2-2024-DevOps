

variable "region" {
  default     = "eu-north-1"
  description = "AWS region"
}

variable "db_password_secret_name" {
  description = "The name of the AWS Secrets Manager secret where the DB password is stored"
  type        = string
}