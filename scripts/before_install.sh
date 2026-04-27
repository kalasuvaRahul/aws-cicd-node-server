#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
APP_NAME="aws-cicd-node-server"

echo "Stopping existing application process (if any)..."

# Stop and remove previous PM2 process if present.
pm2 stop "$APP_NAME" || true
pm2 delete "$APP_NAME" || true

mkdir -p "$APP_DIR/logs"
