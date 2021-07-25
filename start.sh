#!/bin/bash
cd /home/container || exit 1

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

if [ "${AUTO_UPDATE}" == "true" ]; then
  echo "Updating SCP: Secret Laboratory"
  steamerr=$( ./steam/steamcmd.sh +login anonymous +force_install_dir /home/container/server_files +app_update 996560 validate +quit 2>&1 > /dev/null)

  if [[ -n "$steamerr" ]]; then
    echo "\033[31mAn error occurred while updating SCP: Secret Laboratory:\033[m"
    printf "\033[31m%s\033[m" "$steamerr"
    exit 1
  fi

  echo "Successfully updated SCP: Secret Laboratory"

  if [ "${INSTALL_EXILED}" == "true" ]; then
    cd server_files || exit 1

    if [ ! -f "Exiled.Installer-Linux" ]; then
      curl -sSL -o Exiled.Installer-Linux https://github.com/Exiled-Team/Exiled/releases/latest/download/Exiled.Installer-Linux
      chmod +x ./Exiled.Installer-Linux
    fi

    echo "Updating EXILED"
    exilederr=$( ./Exiled.Installer-Linux -p /home/container/server_files --appdata /home/container/.config 2>&1 > /dev/null)

    if [[ -n "$exilederr" ]]; then
      echo "\033[31mAn error occurred while updating EXILED:\033[m"
      printf "\033[31m%s\033[m" "$exilederr"
      exit 1
    fi

    echo "Successfully updated EXILED"
  fi
fi

cd /home/container/server_files || exit 1

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}