provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "./module/s3bucket"
  bucket_name = "terraform-s3-test-bucket-shivu"
}