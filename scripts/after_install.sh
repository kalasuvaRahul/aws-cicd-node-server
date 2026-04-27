#!/bin/bash
set -euo pipefail

APP_DIR="/home/ec2-user/aws-cicd-node-server"

echo "Installing dependencies and building app..."
cd "$APP_DIR"

npm ci
npm run build
