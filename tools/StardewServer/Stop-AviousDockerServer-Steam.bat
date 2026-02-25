@echo off
setlocal EnableExtensions

for %%I in ("%~dp0..\..") do set "REPO=%%~fI"
set "ENVFILE=%REPO%\.env.steam"

pushd "%REPO%"
if exist "%ENVFILE%" (
  docker compose --env-file .env.steam -f compose.steam.localmods.yaml down
) else (
  docker compose -f compose.steam.localmods.yaml down
)
set "ERR=%ERRORLEVEL%"
popd

if not "%ERR%"=="0" (
  echo [ERROR] docker compose down failed with code %ERR%.
  exit /b %ERR%
)

echo [INFO] Docker Stardew server (STEAM method) stopped.
exit /b 0
