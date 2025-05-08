while (-not (Test-NetConnection -ComputerName localhost -Port 2000).TcpTestSucceeded) {
    Start-Sleep -Seconds 5
    Write-Host '...CARLA noch nicht bereit...'
}
Write-Host 'CARLA ist bereit!'