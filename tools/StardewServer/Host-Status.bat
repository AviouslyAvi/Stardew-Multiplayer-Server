@echo off
setlocal EnableExtensions

echo === Docker Host Container ===
docker ps -a --filter "name=stardew-server-localmods" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker ps -a --filter "name=stardew-server-steammods" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo.
echo === Quick Endpoints ===
echo LOCAL method Web VNC: https://localhost:3101
echo LOCAL method UDP Port: 24643
echo STEAM method Web VNC: https://localhost:3201
echo STEAM method UDP Port: 24644
exit /b 0
