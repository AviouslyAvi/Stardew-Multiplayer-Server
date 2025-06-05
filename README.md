# Stardew Valley Multiplayer Server (Docker)

[![Docker Building Status](https://github.com/DaanSelen/stardew-multiplayer/actions/workflows/docker.yml/badge.svg)](https://github.com/DaanSelen/stardew-multiplayer/actions/workflows/docker.yml)
[![CodeQL Advanced](https://github.com/DaanSelen/stardew-multiplayer/actions/workflows/codeql.yml/badge.svg)](https://github.com/DaanSelen/stardew-multiplayer/actions/workflows/codeql.yml)

This container is thanks to:<br>
https://github.com/printfuck/stardew-multiplayer-docker

But the reason I made this adaptation is because I saw that the code in the above repository is becoming quite old.<br>
In particular the Debian version, at the moment was 10, which is slowly becoming deprecated.<br>

Therefor this project, it tries to modernize the packages with the same functionality.

# Getting the game files.

Getting the game files is arguably the hardest part. I love this game, and I do recommend buying it for yourself.<br>
Have fun!<br>

For indication on how to package the game yourself look at this document: [Packaging Guide](./guides/packaging.md).

# Building the image:

Once you clone this repository you can build the image using the following command:<br>
Note that you need to package the game yourself, als place it with the correct name in the local root of the repo.
```sh
docker build -f docker/Dockerfile . -t stardew-server:latest
```
If you want to integrate the building directory into the compose, you can use the following:
```yaml
services:
  stardew:
    restart: unless-stopped
    container_name: stardew-server
    build:
      context: .
      dockerfile: docker/Dockerfile
#    image: stardew:latest
    ports:
      - "3001:3001/tcp"
      - "24642:24642/udp"
    volumes:
      - config:/config
      - saves:/config/.config/StardewValley/Saves
#    deploy:
#      resources:
#        reservations:
#          devices:
#            - driver: nvidia
#              count: 1
#              capabilities: [gpu]
volumes:
  config:
  saves:
```
This compose creates the image from the source code once you type `docker compose up -d` with the -d meaning detached (in the background).

# CREDITS:

Mods:<br>
- [Always On Server For Multiplayer](https://github.com/perkmi/Always-On-Server-for-Multiplayer)<br>
- [Automate](https://www.nexusmods.com/stardewvalley/mods/1063)<br>
- [Auto Load Game](https://www.nexusmods.com/stardewvalley/mods/2509)<br>
- [Default On Cheats](https://www.nexusmods.com/stardewvalley/mods/21035)<br>
- [Multi-User Chests](https://www.nexusmods.com/stardewvalley/mods/9856)<br>
- [No Fence Decay Redux](https://www.nexusmods.com/stardewvalley/mods/20802)<br>
- [Non Destructive NPCs](https://forums.stardewvalley.net/threads/unofficial-mod-updates.2096/page-132#post-121034)<br>
- [Skip Intro](https://www.nexusmods.com/stardewvalley/mods/533)<br>
- [Unlimited Players](https://www.nexusmods.com/stardewvalley/mods/2213)<br>

Kind Regards.

And here an example of a succesful run:

```text
[custom-init] No custom services found, skipping...
[migrations] started
[migrations] no migrations found
usermod: no changes
───────────────────────────────────────

      ██╗     ███████╗██╗ ██████╗
      ██║     ██╔════╝██║██╔═══██╗
      ██║     ███████╗██║██║   ██║
      ██║     ╚════██║██║██║   ██║
      ███████╗███████║██║╚██████╔╝
      ╚══════╝╚══════╝╚═╝ ╚═════╝

   Brought to you by linuxserver.io
───────────────────────────────────────

To support LSIO projects visit:
https://www.linuxserver.io/donate/

───────────────────────────────────────
GID/UID
───────────────────────────────────────

User UID:    911
User GID:    911
───────────────────────────────────────
[custom-init] Files found, executing
[custom-init] 00-configure-i3.sh: executing...
'/etc/i3/config' -> '/config/.config/i3/config'
[custom-init] 00-configure-i3.sh: exited 0
[custom-init] 99-entrypoint.sh: executing...
Creating Directory: autoload
Creating Directory: always_on_server
Moving config: autoload
Moving config: always on server
'/data/stardewvalley/Mods/AutoLoadGame/config.json' -> '/config/modconfs/autoload/config.json'
'/data/stardewvalley/Mods/Always On Server/config.json' -> '/config/modconfs/always_on_server/config.json'
Starting the Stardew Valley server instance for the first time...
Starting to follow the SMAPI logs...
Configuring Mods
Launching Stardew Valley...
SMAPI logs are not yet here. waiting 3 seconds...
[custom-init] 99-entrypoint.sh: exited 0
[ls.io-init] done.
_XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be created.

Xvnc KasmVNC 1.3.4 - built Apr 12 2025 19:11:48
Copyright (C) 1999-2018 KasmVNC Team and many others (see README.me)
See http://kasmweb.com for information on KasmVNC.
Underlying X server release 12101007

[mi] mieq: warning: overriding existing handler (nil) with 0x591ff2f39330 for event 2
[mi] mieq: warning: overriding existing handler (nil) with 0x591ff2f39330 for event 3
17
SMAPI logs are not yet here. waiting 3 seconds...
/usr/bin/xterm
[08:57:15 INFO  SMAPI] SMAPI 4.2.1 with Stardew Valley 1.6.15 build 24356 on Unix 6.14.2.1
[08:57:15 INFO  SMAPI] Mods go here: /data/stardewvalley/Mods
[08:57:15 TRACE SMAPI] Log started at 2025-05-08T08:57:15 UTC
[08:57:21 DEBUG SMAPI] Waiting for game to launch...
[08:57:22 TRACE game] Instance_Initialize() finished, elapsed = '00:00:00.9895189'
[08:57:22 DEBUG SMAPI] Loading mod metadata...
[08:57:22 DEBUG SMAPI] Loading mods...
[08:57:22 TRACE SMAPI]    Console Commands (from Mods/ConsoleCommands/ConsoleCommands.dll, ID: SMAPI.ConsoleCommands, assembly version: 4.2.1)...
[08:57:23 TRACE SMAPI]    Save Backup (from Mods/SaveBackup/SaveBackup.dll, ID: SMAPI.SaveBackup, assembly version: 4.2.1)...
[08:57:23 TRACE SMAPI]       Detected direct console access (System.Console type) in assembly SaveBackup.dll.
[08:57:23 TRACE SMAPI]    Always On Server (from Mods/Always On Server/Always On Server.dll, ID: mikko.Always_On_Server, assembly version: 1.0.0)...
[08:57:23 TRACE SMAPI]       Detected reference to StardewModdingAPI.Events.ISpecializedEvents.UnvalidatedUpdateTicked event in assembly Always On Server.dll.
[08:57:23 TRACE SMAPI]    Auto Load Game (from Mods/AutoLoadGame/AutoLoadGame.dll, ID: caraxian.AutoLoadGame, assembly version: 1.0.1)...
[08:57:23 TRACE SMAPI]       Rewrote AutoLoadGame.dll to fix 32-bit architecture...
[08:57:23 TRACE SMAPI]    Skip Intro (from Mods/SkipIntro/SkipIntro.dll, ID: Pathoschild.SkipIntro, assembly version: 1.9.22)...
[08:57:23 TRACE SMAPI]    DefaultOnCheats (from Mods/DefaultOnCheats/DefaultOnCheats.dll, ID: EnderTedi.DefaultOnCheats, assembly version: 1.0.0)...
[08:57:23 TRACE SMAPI]    Unlimited Players by Armitxes (from Mods/UnlimitedPlayers/UnlimitedPlayers.dll, ID: Armitxes.UnlimitedPlayers, assembly version: 2024.4.16)...
[08:57:23 TRACE SMAPI]    Non Destructive NPCs - 1.6 Unofficial update (from Mods/NonDestructiveNPCs/NonDestructiveNPCs.dll, ID: IamSaulC.NonDestructiveNPCs, assembly version: 1.0.0)...
[08:57:23 TRACE SMAPI]       Detected game patcher in assembly NonDestructiveNPCs.dll.
[08:57:23 TRACE SMAPI]    No Fence Decay Redux (from Mods/NoFenceDecayRedux/No Fence Decay - Redux.dll, ID: EnderTedi.NoFenceDecayRedux, assembly version: 1.2.0)...
[08:57:23 TRACE SMAPI]       Detected game patcher in assembly No Fence Decay - Redux.dll.
[08:57:23 TRACE SMAPI]    Multi-User Chest (from Mods/Multi-UserChest/Multi-User Chest.dll, ID: MindMeltMax.MUC, assembly version: 1.0.0)...
[08:57:23 TRACE SMAPI]    Automate (from Mods/Automate/Automate.dll, ID: Pathoschild.Automate, assembly version: 2.3.4)...
[08:57:23 INFO  SMAPI] Loaded 11 mods:
[08:57:23 INFO  SMAPI]    Always On Server 1.20.3-unofficial.5-mikkoperkele by funny-snek & Zuberii | A Headless server mod.
[08:57:23 INFO  SMAPI]    Auto Load Game 1.0.2 by Caraxian | Automatically load a save file when starting.
[08:57:23 INFO  SMAPI]    Automate 2.3.4 by Pathoschild | Lets you automate crafting machines, fruit trees, and more by connecting them to chests.
[08:57:23 INFO  SMAPI]    Console Commands 4.2.1 by SMAPI | Adds SMAPI console commands that let you manipulate the game.
[08:57:23 INFO  SMAPI]    DefaultOnCheats 1.0.0 by EnderTedi | Enable debug commands in chat by default instead of having to use debug togglecheats.
[08:57:23 INFO  SMAPI]    Multi-User Chest 1.0.10 by MindMeltMax | Allows multiple people to open a chest at the same time
[08:57:23 INFO  SMAPI]    No Fence Decay Redux 1.2.0 by EnderTedi | Stops Fence Decay From Occuring
[08:57:23 INFO  SMAPI]    Non Destructive NPCs - 1.6 Unofficial update 1.6.0 by Madara Uchiha - IamSaulC | NPCs no longer destroy placed objects in their paths. They would instead pass through them.
[08:57:23 INFO  SMAPI]    Save Backup 4.2.1 by SMAPI | Automatically backs up all your saves once per day into its folder.
[08:57:23 INFO  SMAPI]    Skip Intro 1.9.22 by Pathoschild | Skips the game's loading intro.
[08:57:23 INFO  SMAPI]    Unlimited Players by Armitxes 2024.4.16 by Armitxes | Remove the maximum player restrictions, build endless cabins.

[08:57:23 INFO  SMAPI]    Patched game code
[08:57:23 INFO  SMAPI]    --------------------------------------------------
[08:57:23 INFO  SMAPI]       These mods directly change the game code. They're more likely to cause errors or bugs in-game; if
[08:57:23 INFO  SMAPI]       your game has issues, try removing these first. Otherwise you can ignore this warning.

[08:57:23 INFO  SMAPI]       - No Fence Decay Redux
[08:57:23 INFO  SMAPI]       - Non Destructive NPCs - 1.6 Unofficial update

[08:57:23 INFO  SMAPI]    Bypassed safety checks
[08:57:23 INFO  SMAPI]    --------------------------------------------------
[08:57:23 INFO  SMAPI]       These mods bypass SMAPI's normal safety checks, so they're more likely to cause errors or save
[08:57:23 INFO  SMAPI]       corruption. If your game has issues, try removing these first.

[08:57:23 INFO  SMAPI]       - Always On Server

[08:57:23 TRACE SMAPI]    Direct console access
[08:57:23 TRACE SMAPI]    --------------------------------------------------
[08:57:23 TRACE SMAPI]       These mods access the SMAPI console window directly. This is more fragile, and their output may not
[08:57:23 TRACE SMAPI]       be logged by SMAPI.

[08:57:23 TRACE SMAPI]       - Save Backup

[08:57:23 DEBUG SMAPI]    No update keys
[08:57:23 DEBUG SMAPI]    --------------------------------------------------
[08:57:23 DEBUG SMAPI]       These mods have no update keys in their manifest. SMAPI may not notify you about updates for these
[08:57:23 DEBUG SMAPI]       mods. Consider notifying the mod authors about this problem.

[08:57:23 DEBUG SMAPI]       - Non Destructive NPCs - 1.6 Unofficial update

[08:57:23 DEBUG SMAPI] Launching mods...
[08:57:23 TRACE Save Backup] No saves found.
[08:57:23 INFO  Unlimited Players by Armitxes] Default player limit set to 10 players.
[08:57:23 TRACE SMAPI]    Found mod-provided API (Pathoschild.Stardew.Automate.Framework.AutomateAPI).
[08:57:23 DEBUG SMAPI] Mods loaded and ready!
[08:57:23 TRACE SMAPI] Checking for updates...
[08:57:24 TRACE game] setGameMode( 'titleScreenGameMode (0)' )
[08:57:24 TRACE game] path '/config/.config/StardewValley/startup_preferences' did not exist and will be created
[08:57:24 TRACE game] Instance_LoadContent() finished, elapsed = '00:00:02.2520896'
[08:57:24 ERROR game] Oops! Steam achievements won't work because Steam isn't loaded. You can launch the game through Steam to fix that.
[08:57:24 INFO  SMAPI] Type 'help' for help, or 'help <cmd>' for a command's usage
[08:57:24 INFO  Unlimited Players by Armitxes] 
[SERVER] Adjusting limit to 10 players.
[08:57:25 INFO  Auto Load Game] Loading Save: 
[08:57:25 TRACE game] gameMode was 'titleScreenGameMode (0)', set to 'loadingMode (6)'.
[08:57:25 TRACE SMAPI] Game loader synchronizing...
[08:57:25 TRACE game] getLoadEnumerator('')
[08:57:25 TRACE SMAPI] Synchronizing 'Load_ReadSave' task...
[08:57:25 TRACE SMAPI]    task complete.
[08:57:25 TRACE game] gameMode was 'loadingMode (6)', set to 'selectGameScreen (9)'.
[08:57:25 DEBUG game] DebugOutput: File does not exist 
[08:57:25 TRACE game] setGameMode( 'titleScreenGameMode (0)' )
[08:57:25 TRACE SMAPI] Game loader done.
[08:57:25 TRACE SMAPI] Context: returning to title
[08:57:25 TRACE game] Disconnected: ExitedToMainMenu
[08:57:25 TRACE game] Window_ClientSizeChanged(); Window.ClientBounds={X:0 Y:0 Width:1024 Height:768}
[08:57:25 TRACE SMAPI]    SMAPI okay.
[08:57:25 TRACE SMAPI]    Checking for updates to 9 mods...
[08:57:26 TRACE SMAPI] Got update-check errors for some mods:
   Unlimited Players by Armitxes: The CurseForge mod with ID '362847' has no valid versions.
[08:57:26 TRACE SMAPI]    All mods up to date.
```
