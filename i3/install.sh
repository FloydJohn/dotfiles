#!/bin/bash

#Installation script for bootstrap
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#cd "$(dirname "$0")/.."
printf "\nWelcome to the i3 linker script!\n"

INST_DIR="$HOME/.i3"
skip=false

if [ -d "$INST_DIR" ]; then
	printf "Directory $INST_DIR already exists. What shoud I do?\n"
	printf "[c]ancel, [o]verwrite > "

	read -n 1 action
	printf "\n"
        case "$action" in
          o )
            skip=false;;
          * )
	    skip=true;;
        esac
fi

if [ "$skip" = true ]; then
	printf "Skipping i3 linking...\n"
else
	ln -sf "$DIR" "$INST_DIR"
	printf "i3 folder linked to $INST_DIR !\n"	
fi


