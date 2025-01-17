provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "instance type of an ec2 instance ex: t2.micro"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

variable "ami_id" {
  description = "Ami id to create an ec2 instance"
  type = string
}

module "ec2" {
  source = "./module/ec2"
  ami_id = var.ami_id
  instance_type = lookup(var.instance_type,terraform.workspace,"t2.micro")
}