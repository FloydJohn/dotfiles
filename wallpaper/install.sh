#!/bin/bash

LOCAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
LOCAL_FILE="$(basename $(find $LOCAL_PATH -name "wallpaper.*"))"
INST_FILE="$HOME/Pictures/$LOCAL_FILE"

printf "Wallpaper Installation - Do you want to install included wallpaper to $INST_FILE ? y/N\n> "
read -n 1 action

case "$action" in 
	y|Y) 
           ln -sf "$LOCAL_PATH/$LOCAL_FILE" "$INST_FILE";;
	*);;
esac


printf "\n"
