# Script para eliminar comentarios de archivos R en producción
$prodDir = "dist\QuantumLLAMA-ETF-Pro-win32-x64\resources\app"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "ELIMINANDO COMENTARIOS DE CÓDIGO R" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Función para eliminar comentarios de un archivo R
function Remove-RComments {
    param($filePath)
    
    Write-Host "Procesando: $(Split-Path $filePath -Leaf)..." -ForegroundColor Yellow
    
    # Leer archivo
    $content = Get-Content $filePath -Raw -Encoding UTF8
    
    # Eliminar comentarios de línea completa (líneas que empiezan con #)
    $content = $content -replace '(?m)^\s*#.*$', ''
    
    # Eliminar comentarios al final de líneas (# después de código)
    $content = $content -replace '\s+#[^"'']*$', ''
    
    # Eliminar líneas vacías múltiples
    $content = $content -replace '(?m)^\s*\r?\n', ''
    
    # Eliminar espacios al inicio y final de líneas
    $content = $content -replace '(?m)^\s+', ''
    $content = $content -replace '(?m)\s+$', ''
    
    # Guardar archivo sin comentarios
    $content | Set-Content $filePath -Encoding UTF8 -NoNewline
    
    Write-Host "   ✓ Comentarios eliminados" -ForegroundColor Green
}

# Archivos R a limpiar
$archivosR = @(
    "main.R",
    "app.R",
    "Estrategia-ETF-Pro.R",
    "descargar_datos_fallback.R"
)

foreach ($archivo in $archivosR) {
    $rutaArchivo = Join-Path $prodDir $archivo
    if (Test-Path $rutaArchivo) {
        Remove-RComments -filePath $rutaArchivo
    }
}

# Limpiar archivos en carpeta core
Write-Host ""
Write-Host "Limpiando carpeta core..." -ForegroundColor Yellow
$coreDir = Join-Path $prodDir "core"
if (Test-Path $coreDir) {
    Get-ChildItem $coreDir -Filter "*.R" | ForEach-Object {
        Remove-RComments -filePath $_.FullName
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "COMENTARIOS ELIMINADOS COMPLETAMENTE" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "El código ahora está sin comentarios y es más difícil de entender." -ForegroundColor Green
