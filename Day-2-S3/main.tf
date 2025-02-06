provider "aws" {
  region="us-east-1"
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = var.bucket_name
  acl = "private"

  tags = {
    name="shivangi"
    env="dev"
  }

}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.terraform_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.terraform_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true 
  restrict_public_buckets = true 
}

