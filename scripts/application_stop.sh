#!/bin/bash
set -euo pipefail

CONTAINER_NAME="aws-cicd-node-server"

echo "Stopping Docker container if running..."
sudo docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
sudo docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true
