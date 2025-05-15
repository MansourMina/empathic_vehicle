while (-not (Test-NetConnection 127.0.0.1 -Port 2000).TcpTestSucceeded) {
    Start-Sleep -Seconds 5
    Write-Host '...CARLA noch nicht bereit...'
}
Write-Host 'CARLA ist bereit!'

