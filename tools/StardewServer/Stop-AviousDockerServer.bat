@echo off
setlocal EnableExtensions

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT=%%~fI"
set "REPO=%ROOT%\stardew-multiplayer"

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
