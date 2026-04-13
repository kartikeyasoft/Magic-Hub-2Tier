# 🧙 Server Magic Input Hub – 2‑Tier Full‑Stack Application

A modern, stylish **task manager** with a **magic spell‑casting theme** – built as a two‑tier web application.  
The frontend (React) communicates with a backend (Node.js + Express) that stores tasks in memory.  
Designed for easy deployment on two separate VMs (or local machines) with Nginx reverse proxy and systemd.

---

## 🏗️ Architecture
<img width="501" height="185" alt="image" src="https://github.com/user-attachments/assets/404363f2-9313-4b49-87bc-a9db8a73ed9c" />



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
- **Frontend VM IP** – will be the public access point.
- **Backend VM IP** (e.g., `192.168.29.38`) – known in advance.
- Both VMs have internet access to install packages.

---







# 🧙 Server Magic Input Hub – 2‑Tier Full‑Stack Application

A modern task manager with a magic spell theme. Frontend (React) + Backend (Node.js/Express). Deploy on two VMs.

## Quick Start

### Backend VM
```bash
git clone <repo>
cd server-magic-hub
sudo bash setup/backend-setup.sh
```

### Frontend VM
1. Edit `setup/frontend-setup.sh` and set `BACKEND_IP` to your backend VM IP.
2. Run:
```bash
sudo bash setup/frontend-setup.sh
```

Then open `http://<frontend-ip>` in your browser.

## Architecture

- Backend: Node.js, port 5000, in‑memory storage.
- Frontend: React + Nginx, proxies `/api` to backend.

2. **Push to a Git repository** (optional but convenient) or directly copy the `server-magic-hub` folder to both VMs.

### On **Backend VM** (VM2):

1. Copy the entire `server-magic-hub` folder to the VM (e.g., via `scp` or Git clone).
2. Navigate into the folder:
   ```bash
   cd server-magic-hub
   ```
3. Run the backend setup script:
   ```bash
   sudo bash setup/backend-setup.sh
   ```
4. Note the backend IP address:
   ```bash
   hostname -I
   ```
   Example output: `192.168.29.38`

### On **Frontend VM** (VM1):

1. Copy the `server-magic-hub` folder to this VM as well.
2. Edit the frontend setup script to set the correct backend IP:
   ```bash
   cd server-magic-hub
   nano setup/frontend-setup.sh
   ```
   Change the line:
   ```bash
   BACKEND_IP="BACKEND_IP_PLACEHOLDER"
   ```
   to:
   ```bash
   BACKEND_IP="192.168.29.38"   # use actual backend IP
   ```
3. Run the frontend setup:
   ```bash
   sudo bash setup/frontend-setup.sh
   ```
4. Access the application at the frontend VM’s IP:
   ```
   http://<frontend-vm-ip>
   ```

### Verification

- Backend API test:  
  `curl http://<backend-ip>:5000/api/todos` should return JSON.
- Frontend web page: shows the **Server Magic Input Hub** UI with 5 default spells.
