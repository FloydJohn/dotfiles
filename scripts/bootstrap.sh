#!/bin/bash

#Bootstrap script: installs any module.

cd "$(dirname "$0")/.."
HOME_DIR=$(pwd -P)

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  #If file exists then...
  if [ -a "$dst" ]
  then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then
	#File is already linked to our $src!
        skip="file already linked to dotfiles directory!";
      else

        printf "File already exists: $dst, what do you want to do?\n[s]kip, [o]verwrite, [b]ackup? >"
        read -n 1 action
	printf "\n"
        case "$action" in
          o )
            overwrite=true;;
          b )
            backup=true;;
          s )
            skip="file skipped manually!";;
          * )
            ;;
        esac

      fi

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      printf "Removed $dst...\n"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      printf "Moved $dst to ${dst}.backup!\n"
    fi

    if ! [ -z "$skip" ]
    then
      printf "Skipped $src: $skip\n"
    fi
  fi

  if [ -z "$skip" ] 
  then
    ln -sf "$1" "$2"
    printf "Linked $1 to $2!\n"
  fi
}

install_dotfiles () {
  printf "Installing dotfiles to home folder ($HOME_DIR)...\n"

  for src in $(find -H "$HOME_DIR" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

install_scripts() {
  printf "Installing all scripts...\n"
  
  for src in $(find -H "$HOME_DIR" -maxdepth 2 -name 'install.sh' -not -path '*.git*')
  do
    chmod a+x $src
    printf "Executing $src...\n"
    /bin/bash $src 
  done
}

printf "\nWelcome to the bootstrap installer.\n"
install_scripts
install_dotfiles
printf "All done! Have a nice day!\n"

