terraform {
  backend "s3" {
    bucket = "shivu-aws-1"
    key = "shivangi/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-lock1"

  }
}