@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

echo [INFO] Stopping Docker host (if already running)...
call "%ROOT%\Stop-AviousDockerServer.bat" >nul 2>&1

echo [INFO] Starting Docker host...
call "%ROOT%\Start-AviousDockerServer-WithLocalMods.bat"
exit /b %errorlevel%
