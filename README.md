# 🚗 CARLA Auto Start Setup Guide

This project provides a ready-to-use script that automatically starts the CARLA simulator (v0.9.15), installs dependencies, and launches traffic and control scripts. It is designed for **Windows users** with minimal technical background.

---

## 🧰 Step-by-Step Setup Instructions

### ✅ Step 1: Install Python 3.7

1. Download Python 3.7 from the official archive:  
   👉 https://www.python.org/ftp/python/3.7.9/python-3.7.9-amd64.exe

2. Run the installer:
   - ✔️ Make sure to check the box that says: **“Add Python to PATH”**
   - Then choose **Customize installation** > ✔️ Leave all defaults checked

3. After installation, rename the Python executable to `python37.exe`:
   - Go to: `C:\Users\<YourName>\AppData\Local\Programs\Python\Python37`
   - Find `python.exe`, and rename it to `python37.exe`

> This step is important to make sure our scripts run consistently.

---

### ✅ Step 2: Clone This Project

1. Open **Command Prompt** or **Git Bash**
2. Run:

```bash
git clone https://github.com/MansourMina/empathic_vehicle.git
cd empathic_vehicle
```

---

### ✅ Step 3: Download and Extract CARLA 0.9.15

1. Go to:  
   👉 https://github.com/carla-simulator/carla/releases/tag/0.9.15

2. Download the **Windows binary** (e.g., `CARLA_0.9.15.zip`)

3. Extract the zip contents **into the `empathic_vehicle/` folder** so that it looks like this:

---

### ✅ Step 4: Run the Simulator

Double-click:

```
run_all.bat
```

This script will:

- Copy your custom config and script files over CARLA’s defaults
- Wait for CARLA to fully launch
- Install Python requirements
- Run traffic generation and manual control

---

## ⚠️ PowerShell Script Blocking

If Windows blocks PowerShell scripts from running, run this command **once** in PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

---

## 📂 Folder Structure (After Setup)

```
empathic_vehicle/
├── CarlaUE4/                    
├── Co-Simulation
├── Engine
├── HDMaps
├── Plugins
├── PythonAPI
├── CHANGELOG
├── Dockerfile
├── LICENSE
├── overrides/                  
│   ├── CarlaUE4/Config/
│   └── PythonAPI/examples/
├── run_all.bat                   ← Main script to run everything
├── wait_for_carla.ps1            ← PowerShell script to wait for CARLA
├── .gitignore
├── wait_for_carla_ready.py
├── README.md
```

---

## ❌ Common Mistakes to Avoid

- ❌ Don't extract CARLA into the root folder — always into the `carla/` subfolder
- ❌ Don't pull this repo into a downloaded CARLA folder
- ✅ Clone the repo first, then extract CARLA

---

## 👷 Need Help?

Reach out to the team if you're stuck or unsure.

Happy simulating! 🚦
