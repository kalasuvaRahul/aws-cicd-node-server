#!/bin/bash
set -e

APP_NAME="aws-cicd-node-server"
APP_DIR="/var/www/$APP_NAME"
AWS_REGION="ap-south-1"

echo "Updating packages..."
apt-get update -y

echo "Installing base packages..."
apt-get install -y curl wget unzip ruby-full software-properties-common nginx awscli docker.io

echo "Enabling Docker..."
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

echo "Creating app directory..."
mkdir -p "$APP_DIR"
chown -R ubuntu:ubuntu "$APP_DIR"

echo "Installing CodeDeploy agent..."
cd /home/ubuntu
wget "https://aws-codedeploy-$AWS_REGION.s3.$AWS_REGION.amazonaws.com/latest/install" -O install
chmod +x ./install
./install auto

systemctl start codedeploy-agent
systemctl enable codedeploy-agent

echo "Configuring Nginx..."
cat > /etc/nginx/sites-available/$APP_NAME <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;

        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';

        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

ln -sf /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled/$APP_NAME
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx
systemctl enable nginx

echo "Creating production env file..."
cat > "$APP_DIR/.env" <<EOF
NODE_ENV=production
PORT=3000
EOF

chown ubuntu:ubuntu "$APP_DIR/.env"

echo "Bootstrap complete."
