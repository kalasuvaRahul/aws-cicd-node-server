#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
CONTAINER_NAME="aws-cicd-node-server"

echo "Preparing host for Docker deployment..."

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found. Installing docker.io..."
  sudo apt-get update -y
  sudo apt-get install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
fi

if ! command -v aws >/dev/null 2>&1; then
  echo "AWS CLI not found. Installing awscli..."
  sudo apt-get update -y
  sudo apt-get install -y awscli
fi

echo "Stopping previous container if present..."
sudo docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
sudo docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true

mkdir -p "$APP_DIR/logs"
