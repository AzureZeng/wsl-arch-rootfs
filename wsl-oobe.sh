#!/bin/bash

#set -ue

DEFAULT_GROUPS='adm,wheel,kvm,render,video'
DEFAULT_UID='1000'

echo 'Welcome to Arch Linux on WSL.'
echo 'This image is built by Azure Zeng. Please read README \e[0;31mcarefully\e[0m.'
echo ''
echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new UNIX username: ' username

  # Create the user
  if /usr/sbin/useradd --uid "$DEFAULT_UID" -m "$username"; then
    passwd "$username"
    ret=$?
    if [[ $ret -ne 0 ]]; then
      /usr/sbin/userdel -r "$username"
      continue
    fi
    if /usr/sbin/usermod "$username" -aG "$DEFAULT_GROUPS"; then
      break
    else
      /usr/sbin/userdel -r "$username"
    fi
  fi
done

echo '\e[0;36m[*]\e[0m Generating locales.'
/usr/bin/locale-gen
echo '\e[0;36m[*]\e[0m Executing command "pacman-key --init"'
pacman-key --init
echo '\e[0;36m[*]\e[0m Executing command "pacman-key --populate"'
pacman-key --populate

echo '\e[0;92mDone! This Arch Linux on WSL installation is ready to use.\e[0m'