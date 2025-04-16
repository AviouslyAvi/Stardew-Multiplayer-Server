# Stardew Valley Multiplayer Server (Docker)

This container is thanks to:<br>
https://github.com/printfuck/stardew-multiplayer-docker

But the reason I made this adaptation is because I saw that the code in the above repository is becoming quite old.<br>
In particular the Debian version, at the moment was 10, which is slowly becoming deprecated.<br>

Therefor this project, it tries to modernize the packages with the same functionality.

# Getting the game files.

Getting the game files is arguably the hardest part. I love this game, and I do recommend buying it for yourself.<br>
It is possible to download the files from my server, but I do not condone this for anything else than the host of your server.<br>
Have fun!

# Building the image:

Once you clone this repository you can build the image using the following command:
```sh
docker build -f docker/Dockerfile . -t stardew-server:latest
```
If you want to integrate the building directory into the compose, you can use the following:
```yaml
services:
  stardew:
    restart: unless-stopped
    build:
      context: .
      dockerfile: docker/Dockerfile
    #image: stardew:latest
    ports:
      - "3001:3001"
    container_name: stardew
    volumes:
      - autoload:/config/autoload
      - saves:/config/.config/StardewValley/Saves
volumes:
  autoload:
  saves:
```
This compose creates the image from the source code once you type `docker compose up -d` with the -d meaning detached (in the background).

Kind regards.
