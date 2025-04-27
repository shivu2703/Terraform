provider "aws" {
  region = "us-east-1"
}

/*
module "ec2" {
  source = "./EC2"
  ami_id=var.ami_id
  instance_type= var.instance_type
}
*/

module "s3" {
  source = "./S3"
  bucket_name = var.bucket_name
}
