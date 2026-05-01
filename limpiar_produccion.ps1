# Script para limpiar carpeta de producción
$prodDir = "dist\QuantumLLAMA-ETF-Pro-win32-x64\resources\app"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "LIMPIEZA DE CARPETA DE PRODUCCIÓN" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 1. Eliminar archivos .md
Write-Host "1. Eliminando archivos .md..." -ForegroundColor Yellow
Get-ChildItem "$prodDir" -Filter "*.md" -Recurse | Remove-Item -Force
Write-Host "   ✓ Archivos .md eliminados" -ForegroundColor Green

# 2. Eliminar archivos .backup
Write-Host "2. Eliminando archivos .backup..." -ForegroundColor Yellow
Get-ChildItem "$prodDir" -Filter "*.backup" -Recurse | Remove-Item -Force
Write-Host "   ✓ Archivos .backup eliminados" -ForegroundColor Green

# 3. Eliminar scripts de build innecesarios
Write-Host "3. Eliminando scripts de build..." -ForegroundColor Yellow
$archivosEliminar = @(
    "build_rinno.R",
    "build_electron_manual.R",
    "electron_build.R",
    "install_and_build.R",
    "ofuscar_codigo.R",
    "rebuild.bat",
    "rebuild.ps1",
    "diagnostico.R",
    "run_shiny.R"
)

foreach ($archivo in $archivosEliminar) {
    $rutaArchivo = Join-Path $prodDir $archivo
    if (Test-Path $rutaArchivo) {
        Remove-Item $rutaArchivo -Force
        Write-Host "   ✓ Eliminado: $archivo" -ForegroundColor Green
    }
}

# 4. Eliminar archivos de configuración innecesarios
Write-Host "4. Eliminando archivos de configuración..." -ForegroundColor Yellow
$configEliminar = @(
    ".dockerignore",
    ".gitignore",
    ".Rprofile",
    ".RData",
    ".Rhistory",
    "Dockerfile",
    "render.yaml"
)

foreach ($archivo in $configEliminar) {
    $rutaArchivo = Join-Path $prodDir $archivo
    if (Test-Path $rutaArchivo) {
        Remove-Item $rutaArchivo -Force
        Write-Host "   ✓ Eliminado: $archivo" -ForegroundColor Green
    }
}

# 5. Eliminar carpetas innecesarias
Write-Host "5. Eliminando carpetas innecesarias..." -ForegroundColor Yellow
$carpetasEliminar = @(
    "ofuscado",
    "Resultados_PRO_v6",
    "build",
    "ui"
)

foreach ($carpeta in $carpetasEliminar) {
    $rutaCarpeta = Join-Path $prodDir $carpeta
    if (Test-Path $rutaCarpeta) {
        Remove-Item $rutaCarpeta -Recurse -Force
        Write-Host "   ✓ Eliminada carpeta: $carpeta" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "LIMPIEZA COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Archivos restantes en producción:" -ForegroundColor Yellow
Get-ChildItem "$prodDir" -File | Select-Object Name, @{Name = "Size(KB)"; Expression = { [math]::Round($_.Length / 1KB, 2) } }
