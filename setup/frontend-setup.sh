#!/bin/bash
# Frontend Setup Script for Server Magic Input Hub
set -e

FRONTEND_DIR="/var/www/magic-hub-frontend"
BACKEND_IP="BACKEND_IP_PLACEHOLDER"   # <--- CHANGE THIS TO YOUR BACKEND VM IP

echo "🧙 Setting up Server Magic Input Hub Frontend..."

# Install Node.js, nginx, ufw
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs nginx ufw

# Create React app
cd /var/www
sudo rm -rf $FRONTEND_DIR
npx create-react-app magic-hub-frontend
cd $FRONTEND_DIR

# Install extra packages
npm install axios styled-components

# Add FontAwesome CDN
sed -i '/<head>/a <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">' public/index.html

# Copy custom App.js from repo (assuming script run from project root)
if [ -f "../../frontend/src/App.js" ]; then
    cp ../../frontend/src/App.js src/App.js
else
    echo "❌ Frontend App.js not found. Please run this script from the server-magic-hub directory."
    exit 1
fi

# Set backend IP
sed -i "s|BACKEND_IP_PLACEHOLDER|$BACKEND_IP|g" src/App.js

# Build
npm run build

# Deploy to nginx
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/

# Configure nginx site
sudo tee /etc/nginx/sites-available/magic-hub-frontend > /dev/null << EOF
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location /api {
        proxy_pass http://$BACKEND_IP:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/magic-hub-frontend /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl restart nginx

# Firewall
sudo ufw allow 80/tcp
echo "y" | sudo ufw enable

echo "✨ Frontend ready! Access at http://$(hostname -I | awk '{print $1}')"
