#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"

echo "Installing dependencies and building app..."
cd "$APP_DIR"

echo "Installing runtime dependencies..."
npm ci --omit=dev --no-audit --no-fund
