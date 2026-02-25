# Quickstart (Avious Fork)

This is the simplest way to use this repo on Windows with Docker.

## What you need

- Docker Desktop running
- A legal copy of Stardew Valley
- Your own `latest.tar.gz` game package in the repo root (`stardew-multiplayer/latest.tar.gz`)
  - See upstream packaging guide if needed: `guides/packaging.md`

## Fastest setup (LOCAL method)

1. Put your packaged game file here:
   - `stardew-multiplayer/latest.tar.gz`
2. (Optional) Add your mods into:
   - `stardew-multiplayer/mods`
3. Start the server:
   - `.\tools\StardewServer\Switch-To-DockerHost.bat`
4. Open the web client:
   - `https://localhost:3101`
5. Log in with the default web VNC credentials:
   - Username: `stardew`
   - Password: `stardew`
6. In Stardew, create/load your farm and enable multiplayer.

## Steam method (optional)

Use this if you want Docker to download the game from Steam instead of using `latest.tar.gz`.

1. Create `.env.steam` in the repo root:
   - Copy `.env.steam.example` to `.env.steam`
   - Fill in `STEAM_USER` and `STEAM_PASS`
2. Start Steam-mode server:
   - `.\tools\StardewServer\Switch-To-DockerHost-Steam.bat`
3. Open:
   - `https://localhost:3201`

## Ports

LOCAL mode (`compose.localmods.yaml`)
- Web VNC (HTTPS): `3101`
- Raw VNC: `3100`
- Stardew UDP: `24643`

STEAM mode (`compose.steam.localmods.yaml`)
- Web VNC (HTTPS): `3201`
- Raw VNC: `3200`
- Stardew UDP: `24644`

## Useful commands

- Status: `.\tools\StardewServer\Host-Status.bat`
- Logs (LOCAL): `.\tools\StardewServer\Logs-AviousDockerServer.bat`
- Logs (STEAM): `.\tools\StardewServer\Logs-AviousDockerServer-Steam.bat`
- Stop (LOCAL): `.\tools\StardewServer\Stop-AviousDockerServer.bat`
- Stop (STEAM): `.\tools\StardewServer\Stop-AviousDockerServer-Steam.bat`

## Notes

- Web VNC is HTTPS and uses a self-signed cert, so the browser warning is expected.
- Only run one mode at a time (the switch scripts stop the other mode first).
- This repo does not include Stardew game files.
