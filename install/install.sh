#!/bin/bash

# Download SteamCMD
cd /tmp || exit 1
curl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

# Extract SteamCMD
mkdir -p /mnt/server/steam
tar -xzvf steamcmd.tar.gz -C /mnt/server/steam
cd /mnt/server/steam || exit 1

# Make SteamCMD work
chown -R root:root /mnt
export HOME=/mnt/server

# Install the server
mkdir -p /mnt/server/server_files
./steamcmd.sh +login anonymous +force_install_dir /mnt/server/server_files +app_update 996560 validate +quit

mkdir -p "/mnt/server/.config/SCP Secret Laboratory/config/$SERVER_PORT"
cp /config_localadmin.txt "/mnt/server/.config/SCP Secret Laboratory/config/$SERVER_PORT/config_localadmin.txt"

# Install EXILED (if enabled)
if [ "${INSTALL_EXILED}" == "true" ]; then
  cd /mnt/server/server_files || exit 1

  curl -sSL -o Exiled.Installer-Linux https://github.com/Exiled-Team/Exiled/releases/latest/download/Exiled.Installer-Linux
  chmod +x ./Exiled.Installer-Linux
  ./Exiled.Installer-Linux -p /mnt/server/server_files --appdata /mnt/server/.config

  cd /mnt/server || exit 1
fi