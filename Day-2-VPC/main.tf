provider "aws" {
  region = "us-east-1"
}

variable "cidr_range" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr_range

  tags = {
    name= "My-demo-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    name="PublicSubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    name="MyIGW"
  }
}

resource "aws_route_table" "public_rt" {
   vpc_id = aws_vpc.demo-vpc.id

   tags = {
     Name="PublicRouteTable"
   }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_security_group" "allow_ssh_http" {
  name= "sg_for_ssh_http"  
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port = 8000
    from_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name="AllowSshHttp"
  }
}

resource "aws_instance" "demo-instance" {
  ami = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name = "windows-demo"
  vpc_security_group_ids = [ aws_security_group.allow_ssh_http.id ]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name="DemoEc2"
  }
}
