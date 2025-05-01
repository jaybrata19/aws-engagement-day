resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

# Define the bucket policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "ReadAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::328526511201:user/eruser308"]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}/*",
      "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}"
    ]
  }
}

# S3 bucket configuration
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.bucket_name}-${random_string.random.result}"
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

# Enable versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}