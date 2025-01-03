provider "aws" {
  region="us-east-1"
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket_prefix = var.bucket_name
  acl = "private"

  tags = {
    name="shivangi"
    env="dev"
  }

  versioning {
    enabled = true
  }
}

