@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

echo [INFO] Stopping LOCAL Docker host (if already running)...
call "%ROOT%\Stop-AviousDockerServer.bat" >nul 2>&1

echo [INFO] Stopping STEAM Docker host (if already running)...
call "%ROOT%\Stop-AviousDockerServer-Steam.bat" >nul 2>&1

echo [INFO] Starting STEAM Docker host...
call "%ROOT%\Start-AviousDockerServer-WithSteam.bat"
exit /b %errorlevel%
