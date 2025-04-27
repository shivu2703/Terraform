provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  description = "ami value of the instance"
}

variable "instance_type" {
  description = "instance type of ec2 instance for eg: t2.micro"
}

resource "aws_instance" "workspace_instance" {
  ami= var.ami_id
  instance_type = var.instance_type
}