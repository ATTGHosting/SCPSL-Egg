#!/bin/bash
cd /home/container || exit 1

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

if [ "${AUTO_UPDATE}" == "true" ]; then
  ./steam/steamcmd.sh +login anonymous +force_install_dir /home/container/server_files +app_update 996560 validate +quit

  if [ "${INSTALL_EXILED}" == "true" ]; then
    cd server_files || exit 1

    if [ ! -f "Exiled.Installer-Linux" ]; then
      curl -sSL -o Exiled.Installer-Linux https://github.com/Exiled-Team/Exiled/releases/latest/download/Exiled.Installer-Linux
      chmod +x ./Exiled.Installer-Linux
    fi

    ./Exiled.Installer-Linux -p /home/container/server_files --appdata /home/container/.config
  fi
fi

cd /home/container || exit 1

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}