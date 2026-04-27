#!/bin/bash
set -euo pipefail

APP_DIR="/home/ec2-user/aws-cicd-node-server"
PID_FILE="$APP_DIR/app.pid"

echo "Stopping existing application process (if any)..."

if [ -f "$PID_FILE" ]; then
  PID="$(cat "$PID_FILE")"
  if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
    kill "$PID"
    sleep 2
    if kill -0 "$PID" 2>/dev/null; then
      kill -9 "$PID"
    fi
  fi
  rm -f "$PID_FILE"
fi

# Fallback cleanup in case the previous run missed PID tracking.
pkill -f "node dist/index.js" || true

mkdir -p "$APP_DIR/logs"
