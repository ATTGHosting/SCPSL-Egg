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

# Install EXILED (if enabled)
if [ "${INSTALL_EXILED}" == "true" ]; then
  cd /mnt/server/server_files || exit 1

  curl -sSL -o Exiled.Installer-Linux https://github.com/Exiled-Team/Exiled/releases/latest/download/Exiled.Installer-Linux
  chmod +x ./Exiled.Installer-Linux
  mkdir -p /mnt/server/.config
  ./Exiled.Installer-Linux -p /mnt/server/server_files --appdata /mnt/server/.config

  cd /mnt/server || exit 1
fi