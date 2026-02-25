@echo off
setlocal EnableExtensions

for %%I in ("%~dp0..\..") do set "REPO=%%~fI"

pushd "%REPO%"
docker compose -f compose.localmods.yaml logs -f --tail=200
set "ERR=%ERRORLEVEL%"
popd

exit /b %ERR%
