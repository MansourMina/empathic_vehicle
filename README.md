# CARLA Auto Start Script

This project includes a batch script (`run_all.bat`) to automatically start the CARLA simulator and run traffic and control scripts.

---

## Contents

- `run_all.bat` → Main script that starts CARLA and all other steps
- `wait_for_carla.ps1` → PowerShell script (called automatically by `run_all.bat`) that waits until CARLA is ready

---

## How to use

1. Double-click `run_all.bat`.

2. What it does:
   - Starts the CARLA simulator in low quality mode.
   - Waits until CARLA is fully running.
   - Installs Python requirements (`requirements.txt`).
   - Runs `generate_traffic.py` to add traffic.
   - Starts `manual_control.py` in another window.

---

## ⚠ Important

- Make sure you have Python and pip installed.
- Run this on **Windows**.
- If PowerShell scripts are blocked, run this command in PowerShell (once):
  
  ```powershell
  Set-ExecutionPolicy Bypass -Scope CurrentUser
