terraform {
  backend "s3" {
    bucket="shivu-aws-1"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}