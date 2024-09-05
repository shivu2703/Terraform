terraform {
  backend "s3" {
    bucket = "shivangi-s3-demo-statefile"
    key    = "shivangi/terraform.tfstate"
    region = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
