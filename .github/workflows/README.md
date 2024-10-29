# NestJS CI/CD Pipeline with GitHub Actions

This repository uses GitHub Actions to automate the CI/CD pipeline for a NestJS application. The workflows cover:

1. **Continuous Integration (CI)**: Builds, tests, and pushes a Docker image to Amazon ECR when a pull request is made to the `main` branch.
2. **Continuous Deployment (CD)**: Deploys the Docker image from Amazon ECR to an EC2 instance managed by an Auto Scaling Group (ASG) with rolling updates, triggered when changes are merged into the `main` branch.

## Workflow Overview

### CI Workflow (`ci.yml`)

This workflow runs on pull requests to the `main` branch and includes:

- **Build and Test**: Installs dependencies, runs tests, and builds a Docker image of the application.
- **Push to Amazon ECR**: Tags the Docker image based on the branch and commit SHA, then pushes it to an ECR repository. If the branch is `main`, the image is also tagged as `latest`.

### Deployment Workflow (`deploy.yml`)

This workflow runs on pushes to the `main` branch and includes:

- **Update ASG Launch Template**: Updates the ASG's launch template with the latest Docker image tag from ECR.
- **Rolling Update**: Triggers an ASG instance refresh to perform a rolling deployment of EC2 instances with the new launch template version.

## Prerequisites

1. **Amazon Web Services (AWS) Account** with the following resources:
   - **Amazon ECR Repository**: For storing Docker images of the application.
   - **Auto Scaling Group (ASG)**: For deploying the application to EC2 instances.
   - **Launch Template**: Configured to pull and run the Docker image from ECR.

2. **GitHub Repository Secrets**: Set the following secrets in your GitHub repository settings:
   - `AWS_ACCOUNT_ID`: Your AWS account ID.
   - `AWS_REGION`: AWS region (e.g., `us-east-1`).
   - `ECR_REPOSITORY`: Name of the ECR repository.
   - `LAUNCH_TEMPLATE_ID`: ID of the launch template associated with the ASG.
   - `ASG_NAME`: Name of the Auto Scaling Group.
   - IAM Role for GitHub Actions with permissions for ECR and ASG management.

3. **IAM Role for OIDC Integration**: Set up an IAM role with OIDC integration for GitHub Actions. This role must have permissions to access ECR and update ASG configurations.

## CI Workflow Configuration (`ci.yml`)

The CI workflow is defined in `.github/workflows/ci.yml` and includes the following steps:

1. **Checkout Code**: Retrieves the latest code from the pull request.
2. **Install Dependencies**: Installs the necessary packages.
3. **Run Tests**: Executes tests to validate the application.
4. **Configure AWS Credentials**: Uses OIDC to authenticate with AWS and access ECR.
5. **Build and Push Docker Image**: Builds the Docker image, tags it with the branch and commit SHA, and pushes it to ECR. If the branch is `main`, it also updates the `latest` tag.

