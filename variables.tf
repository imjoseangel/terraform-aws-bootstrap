variable "name" {
  description = "name of the S3 bucket"
  type        = string
  default     = "terraform-aws-bootstrap"
}

variable "dynamodb" {
  description = "name of the DynamoDB table"
  type        = string
  default     = "terraform-aws-bootstrap"
}
