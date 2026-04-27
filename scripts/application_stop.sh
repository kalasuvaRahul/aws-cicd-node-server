#!/bin/bash
set -euo pipefail

APP_NAME="aws-cicd-node-server"

echo "Stopping application in PM2 (if running)..."
pm2 stop "$APP_NAME" || true
