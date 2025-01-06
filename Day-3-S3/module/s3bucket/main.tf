provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "test" {
  bucket = var.bucket_name

  tags = {
    name="shivangi"
    environment="dev"
    email="shivangi.katiyar@gmail.com"
  }

  versioning {
    enabled = true
  }

}