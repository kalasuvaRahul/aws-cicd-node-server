#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
CONTAINER_NAME="aws-cicd-node-server"

echo "Starting Docker container..."
cd "$APP_DIR"

IMAGE_URI="$(cat "$APP_DIR/.image_uri")"

sudo docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 127.0.0.1:3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  "$IMAGE_URI"

echo "Application container started: $CONTAINER_NAME"
