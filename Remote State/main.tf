provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "shivangi-s3-demo-xyz-1"
}

resource "aws_instance" "instance_for_utilization" {
  ami = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"

  tags = {
    Name="UtilizationInstance"
  }
}

resource "aws_sns_topic" "cpu_alarm" {
  name = "cpu-utilization-alarm-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.cpu_alarm.arn
  protocol = "email"
  endpoint = "katiyar2703@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "alarm_for_cpu_utilization" {
  alarm_name = "cpu-utilization-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  statistic = "Maximum"
  threshold = 50
  namespace = "AWS/EC2"
  period = 60
  alarm_description = "This alarm triggers when CPU utilization exceeds 50%"
  alarm_actions = [ aws_sns_topic.cpu_alarm.arn ]
  dimensions = {
    InstanceId = aws_instance.instance_for_utilization.id 
  }
}