provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_buckets" {
  count = 3
  bucket = "my-test-bucket-shivu-${count.index}"

  tags = {
    "Env" = "my-bucket-${count.index}" 
  }
}