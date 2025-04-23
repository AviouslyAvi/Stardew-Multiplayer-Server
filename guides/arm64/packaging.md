# How to package Stardew Valley

This small guide tries to expand on the official guide on how to get the compatibility files.<br>
These can be found here: https://www.stardewvalley.net/compatibility/

Because I have only been able to get this all working based on the Steam version, here is my guide:

# Set compatibility beta.

First off, we need Steam on Linux. You can easily do this on a Linux machine or a Virtual machine with Linux.<br>
An official Debian guide here: https://wiki.debian.org/Steam

In steam, go to Stardew Valley, click on the cog icon, select properties.<br>

> If you cannot find the cog, at the right side of the screen.

Go to betas and select the Compatibility beta. Your game should receive an update.

Once that update is finished, go to the following directory:
```sh
/home/user/.local/share/Steam/steamapps/common
```

You should see something like this:

```sh
user@LX-SURFACE:~/.local/share/Steam/steamapps/common$ ls -l
total 470696
-rw-rw-r-- 1 user user 481935475 Apr 29 20:08  latest.tar.gz
drwxrwxr-x 4 user user      4096 Apr 25 19:44 'Proton 9.0 (Beta)'
drwxrwxr-x 4 user user      4096 Apr 26 15:58 'Proton - Experimental'
drwxrwxr-x 4 user user      4096 Apr 28 14:07 'Proton Hotfix'
drwxr-xr-x 6 user user     20480 Apr 29 20:00 'Stardew Valley'
lrwxrwxrwx 1 user user        54 Apr 18 18:43  Steam.dll -> /home/user/.local/share/Steam/legacycompat/Steam.dll
drwxr-xr-x 3 user user      4096 Apr 28 09:12  SteamLinuxRuntime
drwxrwxr-x 5 user user      4096 Apr 25 19:44  SteamLinuxRuntime_sniper
drwxr-xr-x 6 user user      4096 Apr 28 09:12  SteamLinuxRuntime_soldier
drwxrwxr-x 3 user user      4096 Apr 29 20:00 'Steamworks Shared'
```

And once you are in this directory you can compress Stardew Valley into your home folder.

```sh
tar -zcvf ~/latest.tar.gz Stardew\ Valley/
```

This gives you a usable .tar.gz file with Stardew Valley inside it! You can now build the Docker Container for the server.