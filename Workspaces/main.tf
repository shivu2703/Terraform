provider "aws" {
  region = "us-east-1"
}

variable "ami_idd" {
  description = "ami value of the instance"
}

variable "instance_type" {
  description = "instance type of ec2 instance for eg: t2.micro"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2" {
  source = "./module/ec2"
  ami_id= var.ami_idd
  instance_type= lookup(var.instance_type, terraform.workspace,"t2.micro")
}