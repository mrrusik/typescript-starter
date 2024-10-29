provider "aws" {
  region = var.aws_region
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  type        = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the ALB target group"
  type        = string
}

variable "sns_email" {
  description = "Email address for CloudWatch Alarm notifications"
  type        = string
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# SNS Topic for Notifications
resource "aws_sns_topic" "monitoring_alerts" {
  name = "application-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.monitoring_alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

# CloudWatch ALB Target Health Alarm
resource "aws_cloudwatch_metric_alarm" "alb_target_health_alarm" {
  alarm_name          = "alb-target-health-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1

  dimensions = {
    TargetGroup  = var.alb_target_group_arn
    LoadBalancer = var.alb_arn
  }

  alarm_description = "Triggers if any target behind the ALB becomes unhealthy"
  alarm_actions     = [aws_sns_topic.monitoring_alerts.arn]
}

# CloudWatch ALB Response Time Alarm
resource "aws_cloudwatch_metric_alarm" "alb_response_time_alarm" {
  alarm_name          = "alb-response-time-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0.5 # Response time threshold in seconds (adjust as needed)

  dimensions = {
    TargetGroup  = var.alb_target_group_arn
    LoadBalancer = var.alb_arn
  }

  alarm_description = "Triggers if the ALB response time exceeds the threshold"
  alarm_actions     = [aws_sns_topic.monitoring_alerts.arn]
}
