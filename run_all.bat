@echo off
SET "CARLA_PATH=M:\Innolab\WindowsNoEditor"
SET "PYTHON_VERSION=python37"

echo ============================
echo STARTE CARLA SIMULATOR
echo ============================
start "" "%CARLA_PATH%\CarlaUE4.exe" -quality-level=Low

echo ============================
echo WARTE BIS CARLA AUF PORT 2000 BEREIT IST...
echo ============================
powershell -ExecutionPolicy Bypass -File "%CARLA_PATH%\wait_for_carla.ps1"

echo ============================
echo CARLA IST BEREIT!
echo ============================

echo WARTE 10 SEKUNDEN...
echo ============================
ping -n 11 127.0.0.1 >nul

echo ============================
echo INSTALLIERE REQUIREMENTS + STARTE generate_traffic.py
echo ============================
start cmd /k "cd /d %CARLA_PATH%\PythonAPI\examples && %PYTHON_VERSION% -m pip install -r requirements.txt && %PYTHON_VERSION% generate_traffic.py"

echo ============================
echo WARTE 10 SEKUNDEN...
echo ============================
ping -n 11 127.0.0.1 >nul
echo ============================

echo STARTE manual_control.py
echo ============================
start cmd /k "cd /d %CARLA_PATH%\PythonAPI\examples && %PYTHON_VERSION% manual_control.py --sync"

echo ============================
echo ALLES GESTARTET!
echo ============================
pause
