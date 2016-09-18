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

#Install pacaur
big_print "Installing pacaur"
/bin/bash $my_dir/pacaurInstall.sh

#Install packages
big_print "Installing packages"
while read p; do
	if ! [[ $p = \#* || $p = '' ]] ; then
		nor_print "Installing $p"	
		$INSTALL_COMMAND $p
		wait
	fi	  
done < $my_dir/packages.conf
