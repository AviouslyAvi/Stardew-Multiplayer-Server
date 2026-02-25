@echo off
setlocal EnableExtensions

for %%I in ("%~dp0..\..") do set "REPO=%%~fI"
set "ENVFILE=%REPO%\.env.steam"

if not exist "%ENVFILE%" (
  echo [ERROR] Missing "%ENVFILE%".
  echo [ERROR] Copy .env.steam.example to .env.steam in the repo root and fill in STEAM_USER / STEAM_PASS.
  exit /b 1
)

echo [INFO] Starting Docker Stardew server (STEAM method) with local mods overlay...
pushd "%REPO%"
docker compose --env-file .env.steam -f compose.steam.localmods.yaml up -d --build
set "ERR=%ERRORLEVEL%"
popd

if not "%ERR%"=="0" (
  echo [ERROR] docker compose up failed with code %ERR%.
  exit /b %ERR%
)

echo [INFO] Docker server requested. Web VNC: https://localhost:3201
echo [INFO] UDP game port mapped to host port 24644.
exit /b 0
