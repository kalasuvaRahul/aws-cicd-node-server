#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
APP_NAME="aws-cicd-node-server"

echo "Stopping existing application process (if any)..."

# Fail fast with clear errors if runtime tools are missing.
command -v node >/dev/null || { echo "node is not installed"; exit 1; }
command -v npm >/dev/null || { echo "npm is not installed"; exit 1; }
command -v pm2 >/dev/null || { echo "pm2 is not installed"; exit 1; }

# Stop and remove previous PM2 process if present.
pm2 stop "$APP_NAME" || true
pm2 delete "$APP_NAME" || true

mkdir -p "$APP_DIR/logs"
