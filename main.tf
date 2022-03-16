#-------------------------------
# S3 Bucket
#-------------------------------
resource "aws_s3_bucket" "main" {
  bucket = var.name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  tags = {
    Terraform = "true"
  }
}


#-------------------------------
# DynamoDB
#-------------------------------

resource "aws_dynamodb_table" "main" {
  name         = var.dynamodb
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.dynamodb
    BuiltBy = "Terraform"
  }
}
