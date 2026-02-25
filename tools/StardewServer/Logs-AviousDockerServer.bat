@echo off
setlocal EnableExtensions

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT=%%~fI"
set "REPO=%ROOT%\stardew-multiplayer"

pushd "%REPO%"
docker compose -f compose.localmods.yaml logs -f --tail=200
set "ERR=%ERRORLEVEL%"
popd

exit /b %ERR%
