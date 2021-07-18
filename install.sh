#!/bin/bash

cd /home/container || exit 1

mkdir -p /home/container/steamcmd
curl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xzvf steamcmd.tar.gz -C steamcmd
rm steamcmd.tar.gz

mkdir -p server_files

./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container/server_files +app_update 996560 validate +qut

if [ "${INSTALL_EXILED}" == "true" ]; then
  cd server_files || exit 1

  wget https://github.com/Exiled-Team/Exiled/releases/latest/download/Exiled.Installer-Linux
  ./Exiled.Installer-Linux -p /home/container/server_files --appdata /home/container/.config

  cd ../ || exit 1
fi