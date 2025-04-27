provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example_bucket" {
   bucket = var.bucket_name

   tags = {
    Env= "dev"
   }
}

/*
resource "aws_s3_bucket_acl" "acl_bucket" {
  bucket = aws_s3_bucket.example_bucket.id
  acl = "private"
}
*/

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.example_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}