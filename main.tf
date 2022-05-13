#-------------------------------
# S3 Bucket
#-------------------------------
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "main" {
  bucket        = var.name
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "main" {
  count                   = var.sse_algorithm == "aws:kms" ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? aws_kms_key.main[0].arn : null
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket.main]
}

#-------------------------------
# DynamoDB
#-------------------------------
#tfsec:ignore:aws-dynamodb-enable-recovery
resource "aws_dynamodb_table" "main" {
  name         = var.dynamodb
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  #TODO: read_capacity  = 2
  #TODO: write_capacity = 2

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.sse_algorithm == "aws:kms" ? aws_kms_key.main[0].arn : null
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.dynamodb
    BuiltBy = "Terraform"
  }
}
