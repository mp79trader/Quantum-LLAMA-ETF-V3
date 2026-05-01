# Script para limpiar y reconstruir
Write-Host "Cerrando procesos de Electron..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.Name -like "*QuantumLLAMA*" -or $_.Name -like "*electron*"} | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Esperando 3 segundos..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

Write-Host "Eliminando carpeta dist..." -ForegroundColor Yellow
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "dist"

Write-Host "Esperando 2 segundos..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

Write-Host "Construyendo ejecutable..." -ForegroundColor Green
npm run build

Write-Host "`nBuild completado!" -ForegroundColor Green
