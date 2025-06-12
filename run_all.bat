@echo off
echo [INFO] Applying project overrides to CARLA files...

xcopy /Y /S "overrides\CarlaUE4\Config\*" "CarlaUE4\Config\"
xcopy /Y /S "overrides\PythonAPI\examples\*" "PythonAPI\examples\"

REM Szenario- und Wetter-Dateien aus zentraler Config lesen
set ROOT=%~dp0
set SCENARIO_FILE=%ROOT%config\selected_scenario.txt
set WEATHER_FILE=%ROOT%config\selected_weather.txt

for /f "usebackq delims=" %%A in ("%SCENARIO_FILE%") do set SCENARIO=%ROOT%%%A
for /f "usebackq delims=" %%A in ("%WEATHER_FILE%") do set WEATHER=%ROOT%%%A

echo [INFO] Overrides applied. Starting CARLA setup...
echo WARTE 5 SEKUNDEN...
echo ============================
ping -n 6 127.0.0.1 >nul

echo Continue with launching Carla and scripts..
SET "PYTHON_VERSION=python37"

echo ============================
echo [INFO] Stelle sicher, dass CARLA-Modul installiert ist
echo ============================

REM Teste ob carla-Modul importierbar ist
%PYTHON_VERSION% -c "import carla" 2>nul

IF %ERRORLEVEL% NEQ 0 (
    echo [WARNUNG] Modul 'carla' nicht gefunden – versuche Installation...

    REM Installiere Voraussetzungen
    %PYTHON_VERSION% -m pip install --upgrade pip setuptools wheel

    REM Installiere carla .whl-Datei direkt
    %PYTHON_VERSION% -m pip install "./PythonAPI/carla/dist/carla-0.9.15-cp37-cp37m-win_amd64.whl"

    REM Teste erneut mit vollem Pfad + direkter Ausgabe
    echo [INFO] Überprüfe carla-Import nach Installation...
    %PYTHON_VERSION% -c "import carla; print('[OK] carla-Modul importiert: Version', carla.__version__)" 2>nul

    IF %ERRORLEVEL% NEQ 0 (
        echo [FEHLER] Modul 'carla' konnte auch nach Installation nicht importiert werden.
        echo Breche ab.
        pause
    )
)

echo [INFO] carla-Modul ist vorhanden.

echo ============================
echo INSTALLIERE PYTHON REQUIREMENTS
echo ============================
start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% -m pip install -r requirements.txt"
start cmd /k "cd /d .\PythonAPI\carla && %PYTHON_VERSION% -m pip install -r requirements.txt"

echo ============================
echo INSTALLIERE CARLA-WHEEL
echo ============================
start cmd /k "cd /d .\PythonAPI\carla\dist && %PYTHON_VERSION% -m pip install carla-0.9.15-cp37-cp37m-win_amd64.whl"

echo ============================
echo STARTE CARLA SIMULATOR
echo ============================
start "" ".\CarlaUE4.exe" -RenderOffScreen -quality-level=Low -nosound -benchmark -carla-server 

echo ============================
echo WARTE BIS CARLA AUF PORT 2000 BEREIT IST...
echo ============================
powershell -ExecutionPolicy Bypass -File ".\wait_for_carla.ps1"

echo ============================
echo CARLA IST BEREIT!
echo ============================

echo WARTE 10 SEKUNDEN...
echo ============================
ping -n 11 127.0.0.1 >nul

echo ============================
echo INSTALLIERE REQUIREMENTS + STARTE generate_traffic.py
echo ============================
start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% generate_traffic.py"

echo ============================
echo [INFO] Starte Szenario: %SCENARIO%
echo [INFO] Mit Wetter:      %WEATHER%
echo ============================
start cmd /k "%PYTHON_VERSION% scenario_launcher.py %SCENARIO% %WEATHER%"

echo ============================
echo WARTE 10 SEKUNDEN...
echo ============================
ping -n 11 127.0.0.1 >nul
echo ============================

echo STARTE manual_control.py
echo ============================
start cmd /k "cd /d .\PythonAPI\examples && %PYTHON_VERSION% manual_control.py --sync"

echo ============================
echo ALLES GESTARTET!
echo ============================
pause

