# Stardew Docker Host Helpers (Avious)

This folder now documents the Docker-first workflow built on top of the upstream `DaanSelen/stardew-multiplayer` project.

Credit:
- Upstream base project: `DaanSelen/stardew-multiplayer`
- This repo adds local Docker helper scripts, runtime external-mod merging, and publishing guidance.

## Docker helper scripts
- `Switch-To-DockerHost.bat`: stop/restart the Docker host container (rebuild included).
- `Switch-To-DockerHost-Steam.bat`: stop/restart the Steam-build Docker host container (rebuild included).
- `Start-AviousDockerServer-WithLocalMods.bat`: `docker compose up -d --build` using `compose.localmods.yaml`.
- `Start-AviousDockerServer-WithSteam.bat`: `docker compose up -d --build` using `compose.steam.localmods.yaml` and `.env.steam`.
- `Stop-AviousDockerServer.bat`: stop the Docker host container.
- `Stop-AviousDockerServer-Steam.bat`: stop the Steam-build Docker host container.
- `Logs-AviousDockerServer.bat`: tail Docker logs.
- `Logs-AviousDockerServer-Steam.bat`: tail Steam-build Docker logs.
- `Host-Status.bat`: quick container status + ports.
- `Update-GitHubModsFromDockerSet.ps1`: optional updater for GitHub-hosted SMAPI mods.

## Current Docker config choices in this repo
- `LOCAL` method (`latest.tar.gz`): Web VNC `https://localhost:3101`, Raw VNC `localhost:3100`, UDP `24643`
- `STEAM` method (`.env.steam` credentials): Web VNC `https://localhost:3201`, Raw VNC `localhost:3200`, UDP `24644`
- Runtime mod merge from repo `stardew-multiplayer/mods` into the container at startup
- MangoHud FPS cap currently set in `stardew-multiplayer/assets/MangoHud.conf`

## Daily use
1. Start/rebuild host:
   ```bat
   .\StardewServer\Switch-To-DockerHost.bat
   ```
   Or Steam method:
   ```bat
   copy .\stardew-multiplayer\.env.steam.example .\stardew-multiplayer\.env.steam
   .\StardewServer\Switch-To-DockerHost-Steam.bat
   ```
2. Open web VNC:
   - LOCAL: `https://localhost:3101`
   - STEAM: `https://localhost:3201`
3. View logs if needed:
   ```bat
   .\StardewServer\Logs-AviousDockerServer.bat
   ```
