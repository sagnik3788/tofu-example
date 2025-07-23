# variables.tf
variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to create"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev / prod / …)"
}
