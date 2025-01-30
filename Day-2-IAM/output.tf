output "group_name" {
  value = aws_iam_group.group_for_users.name
}

output "users_name" {
  value = [ aws_iam_user.user1.name,
            aws_iam_user.user2.name
    ]
}