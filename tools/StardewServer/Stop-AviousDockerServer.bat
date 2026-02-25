@echo off
setlocal EnableExtensions

for %%I in ("%~dp0..\..") do set "REPO=%%~fI"

pushd "%REPO%"
docker compose -f compose.localmods.yaml down
set "ERR=%ERRORLEVEL%"
popd

if not "%ERR%"=="0" (
  echo [ERROR] docker compose down failed with code %ERR%.
  exit /b %ERR%
)

echo [INFO] Docker Stardew server stopped.
exit /b 0
