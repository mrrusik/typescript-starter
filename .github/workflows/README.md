# NestJS CI/CD Pipeline

## Overview
This pipeline automates the build and deployment of the NestJS application using GitHub Actions. It deploys the application to an AWS EC2 instance and includes basic health checks.

## Setup Instructions

1. **Fork and Clone the Repository**.
   - Clone the repository to your GitHub account.

2. **Configure AWS Secrets in GitHub**:
   - Add `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION` in the repository secrets.

3. **Deploy to AWS EC2**:
   - Set up an EC2 instance and allow traffic on the port used by the NestJS application (default: 3000).
   - Update `<EC2_PUBLIC_IP>` in the workflow file with your instance’s IP address.

4. **Run the Pipeline**:
   - Push changes to the main branch to trigger the CI/CD pipeline.
   - The pipeline builds, deploys, and verifies the application.

## Monitoring
Basic response checks are set up using `curl` in the GitHub Actions workflow. Alternatively, you can set up third-party tools or AWS CloudWatch for monitoring.
