@echo off
setlocal EnableExtensions

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT=%%~fI"
set "REPO=%ROOT%\stardew-multiplayer"
set "TARBALL=%REPO%\latest.tar.gz"

if not exist "%TARBALL%" (
  echo [ERROR] Missing "%TARBALL%".
  echo [ERROR] This repo does not include Stardew game files.
  echo [ERROR] Create/provide your own latest.tar.gz from a legally owned copy of Stardew Valley and place it in stardew-multiplayer\.
  exit /b 1
)

echo [INFO] Starting Docker Stardew server with local mods overlay (mounting repo .\mods folder)...
pushd "%REPO%"
docker compose -f compose.localmods.yaml up -d --build
set "ERR=%ERRORLEVEL%"
popd

if not "%ERR%"=="0" (
  echo [ERROR] docker compose up failed with code %ERR%.
  exit /b %ERR%
)

echo [INFO] Docker server requested. Web VNC: https://localhost:3101
echo [INFO] UDP game port mapped to host port 24643.
exit /b 0
