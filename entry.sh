#!/bin/bash

echo "Installing V Rising ..."
"${STEAMCMD}" +force_install_dir "${STEAMAPPDIR}" +login anonymous +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

echo "Generating initial Wine configuration..."
winecfg

sleep 5

echo "set steamapp id"
export SteamAppId=1604030
export STEAMAPPID=1604030

echo "Starting server..."
WINEDLLOVERRIDES=${DLL} xvfb-run wine64 /app/vrising/VRisingServer.exe -serverName "$SERVERNAME" -saveName "$SAVENAME" -persistentDataPath "/app/vrising/saves" 2>&1 | tee ${STEAMAPPDIR}/entry.log
