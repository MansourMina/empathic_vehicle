@echo off
echo [INFO] Applying project overrides to CARLA files...

xcopy /Y /S "overrides\CarlaUE4\Config\*" "CarlaUE4\Config\"
xcopy /Y /S "overrides\PythonAPI\examples\*" "PythonAPI\examples\"

echo [INFO] Overrides applied. Starting CARLA setup...
@REM echo WARTE 5 SEKUNDEN...
@REM echo ============================
@REM ping -n 6 127.0.0.1 >nul

echo Continue with launching Carla and scripts..
SET "PYTHON_VERSION=python37"

start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% -m pip install -r requirements.txt
echo ============================
echo STARTE CARLA SIMULATOR
echo ============================
start "" ".\CarlaUE4.exe" -RenderOffScreen

echo ============================
echo WARTE BIS CARLA AUF PORT 2000 BEREIT IST...
echo ============================
powershell -ExecutionPolicy Bypass -File ".\wait_for_carla.ps1"

echo ============================
echo CARLA IST BEREIT!
echo ============================

@REM echo WARTE 10 SEKUNDEN...
@REM echo ============================
@REM ping -n 11 127.0.0.1 >nul

echo ============================
echo INSTALLIERE REQUIREMENTS + STARTE generate_traffic.py
echo ============================
start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% generate_traffic.py"

@REM echo ============================
@REM echo WARTE 10 SEKUNDEN...
@REM echo ============================
@REM ping -n 11 127.0.0.1 >nul
@REM echo ============================

echo STARTE manual_control.py
echo ============================
start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% manual_control.py --res 3840x1080 --sync"

echo ============================
echo ALLES GESTARTET!
echo ============================
pause
