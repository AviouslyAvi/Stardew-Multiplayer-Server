@echo off
setlocal EnableExtensions

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT=%%~fI"
set "REPO=%ROOT%\stardew-multiplayer"
set "ENVFILE=%REPO%\.env.steam"

pushd "%REPO%"
if exist "%ENVFILE%" (
  docker compose --env-file .env.steam -f compose.steam.localmods.yaml logs -f --tail=200
) else (
  docker compose -f compose.steam.localmods.yaml logs -f --tail=200
)
set "ERR=%ERRORLEVEL%"
popd

exit /b %ERR%
