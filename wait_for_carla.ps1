Write-Host 'Warte auf Verbindung zu CARLA-Port 2000...'
while (-not (Test-NetConnection 127.0.0.1 -Port 2000).TcpTestSucceeded) {
    Start-Sleep -Seconds 5
    Write-Host '...Port noch nicht offen...'
}

Write-Host 'CARLA-Port erreichbar...'
