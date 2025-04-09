# Base image
FROM linuxserver/webtop:debian-i3-version-90ba1752

RUN apt-get update \
    && apt-get install -y \
        bash \
        xterm \
        curl \
        libstdc++6 \
        build-essential \
        libc6 \
        libicu-dev \
        unzip \
    && mkdir -p /data/nexus

# DOTNET SDK
RUN curl -L -o ./packages-microsoft-prod.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-9.0

COPY ./latest.tar.gz /tmp
# RUN curl -o /tmp/latest.tar.gz https://eris.cc/Stardew_1.6.15.tar.gz \
RUN tar zxf /tmp/latest.tar.gz -C /data \
    && rm /tmp/latest.tar.gz \
    && mv /data/Stardew\ Valley /data/stardewvalley

RUN curl -L -o /tmp/nexus.zip https://github.com/Pathoschild/SMAPI/releases/download/4.2.1/SMAPI-4.2.1-installer.zip \
    && unzip /tmp/nexus.zip -d /data/nexus \
    && SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true \
    /bin/bash -c '/data/nexus/SMAPI\ 4.2.1\ installer/internal/linux/SMAPI.Installer --install --game-path "/data/stardewvalley" <<< "2"'

COPY ./mods/* /data/stardewvalley/Mods/

WORKDIR /data

RUN mkdir -p /custom-cont-init.d

# Make the default i3 message go away for a clean startup.
COPY ./scripts/configure-i3.sh /custom-cont-init.d/00-configure-i3.sh

# Place the entrypoint which actually starts Stardew Valley!
COPY ./entrypoint.sh /custom-cont-init.d/99-entrypoint.sh