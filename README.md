# 🧙 Server Magic Input Hub – 2‑Tier Full‑Stack Application

A modern, stylish **task manager** with a **magic spell‑casting theme** – built as a two‑tier web application.  
The frontend (React) communicates with a backend (Node.js + Express) that stores tasks in memory.  
Designed for easy deployment on two separate VMs (or local machines) with Nginx reverse proxy and systemd.

![UI Preview](https://via.placeholder.com/800x400?text=Server+Magic+Input+Hub+UI)  
*(Replace with actual screenshot)*

---

## 🏗️ Architecture

<svg width="600" height="400" xmlns="http://www.w3.org/2000/svg">
  <style>
    .box {
      fill: #4A90E2;
      stroke: #333;
      stroke-width: 2;
    }
    .text {
      font-family: Arial, sans-serif;
      font-size: 14px;
      fill: white;
    }
    .arrow {
      fill: none;
      stroke: #333;
      stroke-width: 2;
      marker-end: url(#arrowhead);
    }
    .label {
      font-family: Arial, sans-serif;
      font-size: 12px;
      fill: #333;
    }
  </style>
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="0" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" />
    </marker>
  </defs>
  
  <!-- Frontend VM -->
  <rect x="50" y="50" width="200" height="150" class="box"/>
  <text x="150" y="70" class="text" text-anchor="middle">Frontend VM (VM1)</text>
  
  <rect x="70" y="90" width="160" height="40" class="box"/>
  <text x="150" y="115" class="text" text-anchor="middle">Nginx (Port 80)</text>
  
  <rect x="70" y="140" width="160" height="40" class="box"/>
  <text x="150" y="165" class="text" text-anchor="middle">React SPA (build)</text>
  
  <!-- Backend VM -->
  <rect x="350" y="50" width="200" height="150" class="box"/>
  <text x="450" y="70" class="text" text-anchor="middle">Backend VM (VM2)</text>
  
  <rect x="370" y="90" width="160" height="40" class="box"/>
  <text x="450" y="115" class="text" text-anchor="middle">Node.js (Port 5000)</text>
  
  <rect x="370" y="140" width="160" height="40" class="box"/>
  <text x="450" y="165" class="text" text-anchor="middle">In‑memory store</text>
  
  <!-- Arrows -->
  <line x1="250" y1="115" x2="350" y2="115" class="arrow"/>
  <text x="300" y="105" class="label" text-anchor="middle">/api/*</text>
</svg>

