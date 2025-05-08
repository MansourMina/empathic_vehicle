@echo off
echo ============================
echo STARTE CARLA SIMULATOR
echo ============================
start "" "M:\Carla\WindowsNoEditor\CarlaUE4.exe" -quality-level=Low

echo ============================
echo WARTE BIS CARLA AUF PORT 2000 BEREIT IST...
echo ============================
powershell -ExecutionPolicy Bypass -File "M:\Carla\WindowsNoEditor\wait_for_carla.ps1"

echo ============================
echo CARLA IST BEREIT!
echo ============================

echo ============================
echo INSTALLIERE REQUIREMENTS + STARTE generate_traffic.py
echo ============================
start cmd /k "cd /d M:\Carla\WindowsNoEditor\PythonAPI\examples && python37 -m pip install -r requirements.txt && python37 generate_traffic.py"

echo ============================
echo STARTE manual_control.py
echo ============================
start cmd /k "cd /d M:\Carla\WindowsNoEditor\PythonAPI\examples && python37 manual_control.py"

echo ============================
echo ALLES GESTARTET!
echo ============================
pause
