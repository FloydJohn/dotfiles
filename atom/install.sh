#!/bin/bash

#This script should install Atom and all my starred plugins.
echo "Installing atom-editor-bin (and gnome-keyring if needed)..."
pacaur -S --needed --noedit --noconfirm -q atom-editor-bin gnome-keyring

apm install --starred
