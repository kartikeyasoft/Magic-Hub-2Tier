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

