FROM steamcmd/steamcmd:ubuntu-20

ARG WINE_REL="stable"
ARG WINE_VER="7.0.0.0~focal-1"

ENV STEAMCMD /usr/bin/steamcmd
ENV STEAMAPPID 1829350
ENV STEAMAPPDIR /app/vrising
ENV SERVERNAME "VRising Server Testing"
ENV SAVENAME "vrisingserver"

ENV WINE_REL=$WINE_REL
ENV WINE_VER=$WINE_VER
# stable, devel, staging
ENV WINE_REPLACE_REL "stable"

# Prepare the environment
RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        software-properties-common \
        gnupg2 \
    && wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        xauth \
        gettext \
        winbind \
        xvfb \
        lib32gcc1 \
    && apt-get install -y --install-recommends --no-install-suggests \
        winehq-${WINE_REL}=${WINE_VER} \
        wine-${WINE_REL}=${WINE_VER} \
        wine-${WINE_REL}-amd64=${WINE_VER} \
        wine-${WINE_REL}-i386=${WINE_VER} \
    && mkdir -p "${STEAMAPPDIR}" \
    && "${STEAMCMD}" +force_install_dir /home/steam/steamworks_sdk +login anonymous \
        +@sSteamCmdForcePlatformType windows +app_update 1007 +quit \
    && cp /home/steam/steamworks_sdk/*64.dll "${STEAMAPPDIR}"/ \
    && apt-get remove --purge -y \
        wget \
        software-properties-common \
        gnupg2 \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY entry.sh /entry.sh

WORKDIR ${STEAMAPPDIR}

EXPOSE 9876/udp
EXPOSE 9877/udp

VOLUME ${STEAMAPPDIR}

ENTRYPOINT "/entry.sh"
