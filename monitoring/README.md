# CloudWatch Monitoring Setup for ALB

This Terraform script sets up basic monitoring for an application deployed behind an Application Load Balancer (ALB), providing uptime and response time checks through CloudWatch. It also configures notifications via Amazon SNS for alerts.

## Overview

- **CloudWatch Alarms for ALB Health**: Monitors the health status of targets behind the ALB.
- **CloudWatch Alarms for Response Time**: Triggers an alert if the response time of targets behind the ALB exceeds a defined threshold.
- **SNS Notifications**: Sends email alerts to the specified email address when alarms are triggered.

## Prerequisites

- AWS account with permissions to create CloudWatch Alarms, SNS topics, and monitor ALB metrics.
- [Terraform](https://www.terraform.io/downloads.html) installed.

## Setup Instructions

1. **Configure Variables**: In `cloudwatch_monitoring_alb.tf`, provide the necessary variables:
   - `alb_arn`: ARN of your Application Load Balancer.
   - `alb_target_group_arn`: ARN of the target group associated with the ALB.
   - `sns_email`: Email address where alarm notifications will be sent.
   - `aws_region`: AWS region where resources will be deployed (default is `us-east-1`).

2. **Initialize Terraform**:
   ```bash
   terraform init
