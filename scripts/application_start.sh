#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
APP_NAME="aws-cicd-node-server"

echo "Starting application..."
cd "$APP_DIR"

# Start with PM2 on first deploy; restart/reload on subsequent deployments.
if pm2 describe "$APP_NAME" > /dev/null 2>&1; then
  pm2 reload ecosystem.config.js --env production
else
  pm2 start ecosystem.config.js --env production
fi

# Ensure PM2 resurrects app processes after reboot.
sudo env PATH="$PATH" pm2 startup systemd -u ubuntu --hp /home/ubuntu || true
pm2 save
echo "Application started with PM2."
