#!/bin/bash
set -euo pipefail

APP_DIR="/var/www/aws-cicd-node-server"
PID_FILE="$APP_DIR/app.pid"
LOG_FILE="$APP_DIR/logs/app.log"

echo "Starting application..."
cd "$APP_DIR"

# Clean up stale PID if it exists.
if [ -f "$PID_FILE" ]; then
  OLD_PID="$(cat "$PID_FILE")"
  if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
    kill "$OLD_PID" || true
    sleep 2
  fi
  rm -f "$PID_FILE"
fi

nohup npm start > "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

echo "Application started with PID $(cat "$PID_FILE")"
