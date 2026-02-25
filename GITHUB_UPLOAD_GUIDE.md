# GitHub Upload Guide (Docker-Only, Avious Fork)

This guide helps you publish your Docker-based Stardew host setup while crediting the upstream project.

Upstream credit:
- Base project: `https://github.com/DaanSelen/stardew-multiplayer`
- Recommended publishing approach: fork DaanSelen's repo first, then apply your Avious changes

## What this repo includes (Avious changes)
- Docker helper scripts in `StardewServer` (`Start/Stop/Logs/Status/Switch`)
- Runtime external-mod merge script in `stardew-multiplayer/scripts/merge-external-mods.sh`
- Dockerfile hook to run that merge script at container startup
- `compose.localmods.yaml` with local ports and repo-local mod mount
- `compose.steam.localmods.yaml` for optional Steam-based build mode
- `scripts/stardew.sh` patch to avoid noisy config symlink failures when optional mods are missing
- MangoHud FPS config changes in `stardew-multiplayer/assets/MangoHud.conf`

## Before you push (important cleanup)
1. Do not commit your game files tarball:
   - `stardew-multiplayer/latest.tar.gz`
   - This is already ignored by `stardew-multiplayer/.gitignore` (`*.tar.gz*`).
   - Repo users should create/provide this file themselves from a legally owned copy of Stardew Valley.
   - The Docker build expects `stardew-multiplayer/latest.tar.gz` to exist locally.
2. Do not commit personal saves/config:
   - `stardew-multiplayer/saved_games/`
   - `stardew-multiplayer/config/`
3. Review secrets/passwords in `stardew-multiplayer/compose.localmods.yaml`:
   - `PASSWORD=...`
   - `CUSTOM_USER=...`
   - Replace with safe defaults before publishing.
4. Do not commit Steam credentials:
   - `stardew-multiplayer/.env.steam` is ignored
   - Commit only `stardew-multiplayer/.env.steam.example`
5. Helper scripts in `StardewServer` are already relative-path based, so they can be reused after cloning.

## Recommended GitHub structure (clean Docker-only publish)
1. Keep:
   - `stardew-multiplayer/`
   - Docker helper scripts in `StardewServer` for Docker (`Start/Stop/Logs/Host-Status/Switch-To-DockerHost`)
   - This guide + Docker-focused README updates
2. Remove or exclude (optional, if you want Docker-only public repo):
   - Windows fallback host scripts (`start_stardew_smapi.bat`, `start_stardew_host_instance*.bat`, task scheduler scripts)
   - Old downloaded mod zip folders in `StardewServer/` (Nexus zip extractions)

## Fork + push workflow (recommended)
1. Fork upstream repo on GitHub:
   - Open `https://github.com/DaanSelen/stardew-multiplayer`
   - Click `Fork`
2. Add your fork as `origin` (inside `stardew-multiplayer`)
   ```powershell
   cd .\stardew-multiplayer
   git remote -v
   ```
3. If this folder is already a git repo and points to upstream, keep upstream as `upstream` and set your fork as `origin`:
   ```powershell
   git remote rename origin upstream
   git remote add origin https://github.com/AviouslyAvi/Stardew-Multiplayer-Server.git
   ```
4. Commit your Avious changes:
   ```powershell
   git status
   git add Dockerfile compose.localmods.yaml compose.steam.localmods.yaml .env.steam.example scripts/merge-external-mods.sh scripts/stardew.sh assets/MangoHud.conf .gitignore
   git commit -m "Add Avious Docker host workflow with runtime external mod merge"
   ```
5. Push to your fork:
   ```powershell
   git push -u origin main
   ```
   - Your fork URL: `https://github.com/AviouslyAvi/Stardew-Multiplayer-Server`

## If you want to include `StardewServer` too
`StardewServer` sits outside the `stardew-multiplayer` git repo. You have two options:

1. Create a separate repo for your helper scripts (simplest)
   - Example repo name: `stardew-docker-host-helpers`
2. Copy the Docker helper scripts into a folder inside your fork
   - Example destination: `stardew-multiplayer/tools/windows-launchers/`

If you want, I can do either repo cleanup step for you next (make helper scripts relative-path and remove Windows fallback files from the publish set).
