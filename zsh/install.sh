#!/bin/bash
#Install zsh
pacaur -S --needed zsh
#Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#Link zshrc to home (absolutely after oh-my-zsh installation...)
ln -s zshrc ~/.zshrc
