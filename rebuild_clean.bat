@echo off
echo ============================================
echo RECONSTRUCCION COMPLETA DEL EJECUTABLE
echo ============================================
echo.

echo Cerrando procesos...
taskkill /F /IM QuantumLLAMA-ETF-Pro.exe 2>nul
taskkill /F /IM electron.exe 2>nul
timeout /t 3 /nobreak >nul

echo.
echo Eliminando carpeta dist...
rd /s /q "dist" 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Si la carpeta no se eliminó, cierra TODAS las ventanas
echo del Explorador de Archivos y presiona ENTER
pause

echo.
echo Eliminando dist nuevamente...
rd /s /q "dist" 2>nul

echo.
echo Construyendo ejecutable...
call npm run build

echo.
echo ============================================
echo BUILD COMPLETADO
echo ============================================
echo.
echo Ejecutable en: dist\QuantumLLAMA-ETF-Pro-win32-x64\
echo.
echo IMPORTANTE: NO elimines comentarios ni limpies archivos.
echo El ejecutable funciona mejor con los archivos originales.
echo.
pause
