provider "aws" {
  region="us-east-1"
  alias = "east"
  
}

provider "aws" {
  region = "us-west-2"
  alias = "west"
}

resource "aws_instance" "EastInstance" {
  ami = var.ami_id_east
  instance_type = var.instanceType
  provider = aws.east
}

resource "aws_instance" "WestInstance" {
  ami = var.ami_id_west
  instance_type = var.instanceType
  provider = aws.west
}