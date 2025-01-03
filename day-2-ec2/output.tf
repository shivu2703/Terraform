output "east_arn" {
 value = aws_instance.EastInstance.arn  
}

output "west_arn" {
 value = aws_instance.WestInstance.arn  
}