# Stardew Valley Multiplayer Server (Docker)

This container is thanks to:<br>
https://github.com/printfuck/stardew-multiplayer-docker

But the reason I made this adaptation is because I saw that the code in the above repository is becoming quite old.<br>
In particular the Debian version, at the moment was 10, which is slowly becoming deprecated.<br>

Therefor this project, it tries to modernize the packages with the same functionality.

# Building the image:

Once you clone this repository you can build the image using the following command:
```sh
docker build -f docker/Dockerfile . -t stardew-server:latest
```

Kind regards.