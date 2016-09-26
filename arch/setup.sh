#!/bin/bash

#Setup for arch-based systems.

INSTALL_COMMAND="pacaur -q -S --noconfirm --needed "
my_dir="$(dirname "$0")"

function big_print {
	printf "===> $1 \n"
}

function nor_print {
	printf "=> $1 \n"
}

function pacaur_install {
  /bin/bash $my_dir/pacaurInstall.sh
}

function packages_install {
  while read p; do
  	if ! [[ $p = \#* || $p = '' ]] ; then
  		nor_print "Installing $p"
  		$INSTALL_COMMAND $p
  		wait
  	fi
  done < $my_dir/packages.conf
}

big_print "Installing pacaur"
pacaur_install

big_print "Installing packages"
packages_install

big_print "Install finished! Exiting.."
