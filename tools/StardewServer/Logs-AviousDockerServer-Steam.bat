@echo off
setlocal EnableExtensions

for %%I in ("%~dp0..\..") do set "REPO=%%~fI"
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
