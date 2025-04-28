provider "aws" {
  region = "us-east-1"
  alias = "east"
}

provider "aws" {
  region = "us-west-2"
  alias = "west"
}


module "ec2" {
  source = "./EC2"
  ami_id_east=var.ami_id_east
  ami_id_west=var.ami_id_west
  instance_type= var.instance_type
}

/*
module "s3" {
  source = "./S3"
  bucket_name = var.bucket_name
}
*/
