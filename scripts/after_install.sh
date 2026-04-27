#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
AWS_REGION="${AWS_DEFAULT_REGION:-ap-south-1}"
ECR_REPOSITORY="aws-cicd-node-server"

cd "$APP_DIR"

AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
IMAGE_URI="${ECR_REGISTRY}/${ECR_REPOSITORY}:latest"

echo "Authenticating Docker to ECR..."
aws ecr get-login-password --region "$AWS_REGION" | sudo docker login --username AWS --password-stdin "$ECR_REGISTRY"

echo "Pulling latest application image: $IMAGE_URI"
sudo docker pull "$IMAGE_URI"

echo "$IMAGE_URI" > "$APP_DIR/.image_uri"
