# 🧙 Server Magic Input Hub – 2‑Tier Full‑Stack Application

A modern, stylish **task manager** with a **magic spell‑casting theme** – built as a two‑tier web application.  
The frontend (React) communicates with a backend (Node.js + Express) that stores tasks in memory.  
Designed for easy deployment on two separate VMs (or local machines) with Nginx reverse proxy and systemd.

![UI Preview](https://via.placeholder.com/800x400?text=Server+Magic+Input+Hub+UI)  
*(Replace with actual screenshot)*

---

## 🏗️ Architecture



- **Frontend (VM1)**: React application served by Nginx. All API calls are proxied to the backend VM.
- **Backend (VM2)**: Node.js + Express REST API. Data is stored in memory (volatile, for demo/development).
- **Communication**: HTTP over private network. CORS enabled.

---

## 🚀 Features

- ✨ **Modern glassmorphism UI** – soft gradients, rounded cards, smooth animations.
- ⚡ **Real‑time task status** – mark tasks as `PENDING` / `EXECUTED` (completed).
- 🧙 **Magic spell theme** – tasks are called “spells”, adding a playful console vibe.
- 🔁 **RESTful API** – full CRUD operations (Create, Read, Update, Delete).
- 🐳 **Docker‑ready** – both frontend and backend can be containerised (optional).
- 🔒 **Systemd integration** – auto‑start and restart on VM boot.

---

## 🛠️ Technologies Used

| Component       | Technology                                 |
|----------------|--------------------------------------------|
| Frontend       | React, Axios, Styled‑Components, FontAwesome |
| Backend        | Node.js, Express, CORS                     |
| Web Server     | Nginx (reverse proxy for frontend)         |
| Process Manager| systemd                                    |
| Firewall       | UFW                                        |
| OS             | Ubuntu / Debian (or any Linux)             |

---

## 📦 Deployment Guide (Two Separate VMs)

### Prerequisites
- Two Linux VMs (or machines) with **Ubuntu 20.04+**.
- **Backend VM IP** (e.g., `192.168.29.38`) – known in advance.
- **Frontend VM IP** – will be the public access point.
- Both VMs have internet access to install packages.

---

### 1️⃣ Backend Setup (VM2)

Run these commands **on the backend VM**.

```bash
# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs ufw

# Create directory
sudo mkdir -p /var/www/magic-hub-backend
sudo chown -R $USER:$USER /var/www/magic-hub-backend
cd /var/www/magic-hub-backend

# Create package.json
cat > package.json << 'EOF'
{
  "name": "magic-hub-backend",
  "version": "1.0.0",
  "description": "Backend for Server Magic Input Hub",
  "main": "server.js",
  "scripts": { "start": "node server.js" },
  "dependencies": { "express": "^4.18.2", "cors": "^2.8.5" }
}
EOF

# Create server.js (copy from the full script below)
# See full server.js content in the repository

# Install dependencies
npm install

# Create systemd service
sudo tee /etc/systemd/system/magic-hub-backend.service > /dev/null << EOF
[Unit]
Description=Server Magic Hub Backend
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=/var/www/magic-hub-backend
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Start service
sudo systemctl daemon-reload
sudo systemctl start magic-hub-backend
sudo systemctl enable magic-hub-backend

# Allow port 5000 in firewall
sudo ufw allow 5000/tcp
echo "y" | sudo ufw enable
