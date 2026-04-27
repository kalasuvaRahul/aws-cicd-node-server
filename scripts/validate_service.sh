#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
CONTAINER_NAME="aws-cicd-node-server"
cd "$APP_DIR"

PORT=3000
if [ -f ".env" ]; then
  ENV_PORT="$(grep -E '^PORT=' .env | tail -n 1 | cut -d'=' -f2- | tr -d '[:space:]' || true)"
  if [ -n "${ENV_PORT:-}" ]; then
    PORT="$ENV_PORT"
  fi
fi

HEALTH_URL="http://127.0.0.1:${PORT}/health"

echo "Validating service at ${HEALTH_URL}..."

if ! sudo docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Container ${CONTAINER_NAME} is not running."
  exit 1
fi

for attempt in {1..24}; do
  if curl --silent --show-error --fail --max-time 5 "$HEALTH_URL" > /dev/null; then
    echo "Service is healthy."
    exit 0
  fi

  echo "Attempt ${attempt}/24 failed; retrying in 5 seconds..."
  sleep 5
done

echo "Service health validation failed."
exit 1
