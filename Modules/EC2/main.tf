provider "aws" {
  region="us-east-1"
  alias = "east"
}

provider "aws" {
  region="us-west-2"
  alias = "west"
}

resource "aws_instance" "ec2_instance_east" {
  ami = var.ami_id_east
  instance_type = var.instance_type
  provider = aws.east
}

resource "aws_instance" "ec2_instance_west" {
  ami = var.ami_id_west
  instance_type = var.instance_type
  provider = aws.west
}


