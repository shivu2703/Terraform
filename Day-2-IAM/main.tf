provider "aws" {
  region = "us-east-1"
}

# create a IAM Group
resource "aws_iam_group" "group_for_users" {
  name = var.group_name
}

# create an IAM User1
resource "aws_iam_user" "user1" {
  name = var.user1_name
}

# create an IAM User2
resource "aws_iam_user" "user2" {
  name = var.user2_name
}

# create a group membership for adding user1 to the group
resource "aws_iam_user_group_membership" "developer_membership_1" {
  groups = [ aws_iam_group.group_for_users.name ]
  user = aws_iam_user.user1.name
}

# create a group membership for adding user2 to the group
resource "aws_iam_user_group_membership" "developer_membership_2" {
  groups = [ aws_iam_group.group_for_users.name ]
  user = aws_iam_user.user2.name
}

# Attach a policy to the group 
resource "aws_iam_group_policy" "developer_policy" {
  name = "developer_policy"
  group = aws_iam_group.group_for_users.name
  policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
        {
            Action = [ 
                "s3:ListBucket", "s3:GetObject" 
            ]
            Effect = "Allow"
            Resource = "*"
        },
     ]
  })
}

