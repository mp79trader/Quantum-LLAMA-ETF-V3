@echo off
echo ============================================
echo LIMPIEZA Y RECONSTRUCCION FORZADA
echo ============================================
echo.

echo Cerrando procesos de Electron...
taskkill /F /IM QuantumLLAMA-ETF-Pro.exe 2>nul
taskkill /F /IM electron.exe 2>nul
timeout /t 3 /nobreak >nul

echo.
echo Intentando eliminar carpeta dist...
rd /s /q "dist" 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Si la carpeta no se eliminó, cierra MANUALMENTE:
echo   1. Explorador de Archivos en la carpeta dist
echo   2. Cualquier editor de código con archivos de dist abiertos
echo   3. Presiona ENTER cuando hayas cerrado todo
pause

echo.
echo Eliminando carpeta dist nuevamente...
rd /s /q "dist" 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Construyendo ejecutable...
call npm run build

echo.
echo ============================================
echo BUILD COMPLETADO
echo ============================================
echo.
echo El ejecutable debería estar en:
echo dist\QuantumLLAMA-ETF-Pro-win32-x64\QuantumLLAMA-ETF-Pro.exe
echo.
pause
