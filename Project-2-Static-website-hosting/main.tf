provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "demo-bucket-website-shivu"
  acl = "private"

  tags = {
    Name="S3WebsiteBucket"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false 
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version= "2012-10-17",
    Statement= [
      {
        Effect= "Allow"
        Principal= "*"
        Action= "s3:GetObject"
        Resource= "arn:aws:s3:::demo-bucket-website-shivu/*"
      }
    ]  
  })
}