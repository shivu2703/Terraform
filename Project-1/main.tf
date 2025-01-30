provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "role_for_ec2" {
  name = "ec2_s3_access_role"
  assume_role_policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
       },
      "Action": "sts:AssumeRole"
    }
   ]
  }
EOF
}

resource "aws_iam_policy" "policy_for_iamrole" {
  name= "s3-read-only-policy"
  policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
   {
    "Effect": "Allow",
    "Action": "s3:PutObject",
    "Resource": "arn:aws:s3:::my-secure-bucket-shivu/*"
   }
  ]
 }
EOF
}

resource "aws_iam_role_policy_attachment" "iamrole_policy_attach" {
  role = aws_iam_role.role_for_ec2.name
  policy_arn = aws_iam_policy.policy_for_iamrole.arn
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "ec2_s3_instance_profile"
  role = aws_iam_role.role_for_ec2.name
}

resource "aws_instance" "instance_for_s3" {
  ami = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name = "windows-demo"
  iam_instance_profile = aws_iam_instance_profile.ec2_iam_profile.name

  tags = {
    Name= "ec2_instance_with_s3_access"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket= "my-secure-bucket-shivu"
  acl = "private"
}

resource "aws_s3_object" "object_to_be_upload" {
  bucket = aws_s3_bucket.test_bucket.bucket
  key = "test_file.txt"
  content = "Hi, from Shivangi!!"
}