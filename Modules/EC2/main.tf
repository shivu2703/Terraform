provider "aws" {
  region="us-east-1"
}

resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
}

