#!/bin/bash
cd /home/container || exit 1

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

if [ "${AUTO_UPDATE}" == "true" ]; then
  ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container/server_files +app_update 996560 validate +qut

  if [ "${INSTALL_EXILED}" == "true" ]; then
    cd server_files || exit 1

    ./Exiled.Installer-Linux -p /home/container/server_files --appdata /home/container/.config

    cd ../ || exit 1
  fi
fi

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}