#!/bin/bash
# Backend Setup Script for Server Magic Input Hub
set -e

BACKEND_DIR="/var/www/magic-hub-backend"
SERVICE_NAME="magic-hub-backend"

echo "🧙 Setting up Server Magic Input Hub Backend..."

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs ufw

# Create directory
sudo mkdir -p $BACKEND_DIR
sudo chown -R $USER:$USER $BACKEND_DIR
cd $BACKEND_DIR

# Copy backend files from local repo (or create them)
# For manual execution, ensure you have copied package.json and server.js into this directory.
# Here we assume the script is run from the project root with backend/ folder available.
if [ -f "../backend/package.json" ]; then
    cp ../backend/package.json .
    cp ../backend/server.js .
else
    echo "❌ Backend source files not found. Please run this script from the server-magic-hub directory."
    exit 1
fi

npm install

# Create systemd service
sudo tee /etc/systemd/system/$SERVICE_NAME.service > /dev/null << EOF
[Unit]
Description=Server Magic Hub Backend (KartikeyaSoft)
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$BACKEND_DIR
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=10
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start $SERVICE_NAME
sudo systemctl enable $SERVICE_NAME

# Firewall
sudo ufw allow 5000/tcp
echo "y" | sudo ufw enable

echo "✨ Backend ready! API running on port 5000"
echo "Test: curl http://$(hostname -I | awk '{print $1}'):5000/api/todos"
