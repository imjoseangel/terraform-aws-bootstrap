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

variable "sse_algorithm" {
  description = "Server-side encryption algorithm. Valid values: AES256, aws:kms"
  type        = string
  default     = "aws:kms"
}
