provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "shivangi" {
  instance_type = "t2.micro"
  ami = "ami-0e86e20dae9224db8"
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "shivangi-s3-demo-xyz-1"
}