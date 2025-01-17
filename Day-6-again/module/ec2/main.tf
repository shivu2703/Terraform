provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "instance type of an ec2 instance ex: t2.micro"
  type = string
}

variable "ami_id" {
  description = "Ami id to create an ec2 instance"
  type = string
}

resource "aws_instance" "example" {
  ami = var.ami_id
  instance_type = var.instance_type
}