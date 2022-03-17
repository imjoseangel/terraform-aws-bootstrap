output "terraform_bucket" {
  description = "The state_bucket name"
  value       = aws_s3_bucket.main.bucket
}

output "dynamodb_lock" {
  description = "The name of the dynamodb lock table"
  value       = aws_dynamodb_table.main.id
}
