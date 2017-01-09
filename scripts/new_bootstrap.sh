#!/bin/bash
#Authors: Alessandro Racheli
#This script should install every dotfile to its right place.
#ex.home files/folders will be linked to ~/.ex
#ex.config files/folders will be linked to ~/.config/ex
#bin/ contents will be linked to /usr/local/bin
#All scripts named install.sh will be ran

#COLORS
RED='\e[31m'
NC='\e[0m' # No Color
GREEN='\e[32m'
YELLOW='\e[33m'
BOLD='\e[01m'

#get script directory
cd "$(dirname $0)/.."
current_dir=$(pwd -P)

function print_msg {
    case $1 in
        "OK" ) printf "[${GREEN}${BOLD}  OK  ${NC}]";;
        "WARN" ) printf "[${YELLOW}${BOLD} WARN $NC]";;
        "ERR"  ) printf "[${RED}${BOLD} ERR  $NC]";;
        "DEBG" ) printf "[${YELLOW}${BOLD} DEBG $NC]";;
        "INFO" ) printf "[${BOLD} INFO ${NC}]";;
        * ) printf "[ $1 ]";;
    esac
    shift
    echo " $@"
}

function test_print_msg {
    print_msg OK   "OK   message!"
    print_msg INFO "INFO message!"
    print_msg WARN "WARN message!"
    print_msg ERR  "ERR  message!"
    print_msg DEBG "DEBG message!"
}

function ask_user {
    if [ $# -ne 1 ]; then
            exit 32
    fi
    print_msg WARN "$1"
    read choice
}

function link_file {
        local src=$1 dst=$2
        ln -sf $src $dst
        print_msg INFO "Linked $src -> $dst"
}

function link_file_confirm {
    local src=$1 dst=$2

    if ! [ -z $autoLink ]
    then
        link_file $src $dst
        exit 0
    fi 
    print_msg DEBG "Link file confirm - autoLink disabled"
    if [ -e "$dst" ]
    then
        print_msg DEBG "File $dst exists."
        #File already exists! Check if its already linked to src
        if [ -h $dst ]
        then
            local currentSrc="$(readlink $dst)"
        fi

        if [ "$currentSrc" = "$src" ]
        then
            print_msg WARN "File $dst already linked. Skipping."
        else
            #File isn't a link or was linked elsewhere. Ask user
            print_msg DEBG "File $dst isn't a link or a link to somewhere else"
            local rep=1
            while [ $rep = 1 ]
            do
                rep=0
                ask_user "File $dst exists. What should I do? (Replace, Backup, Skip (r/b/s): "
                case $choice in
                    "r" | "R" ) link_file $src $dst;;
                    "b" | "B" ) mv $dst "$dst.backup"
                                print_msg INFO "Moved $dst to $dst.backup"
                                link_file $src $dst;;
                    "s" | "S" ) print_msg INFO "Skipped $src.";;
                    * ) rep=1;;
                esac
            done
        fi            
    else
        #Simply link
        link_file $src $dst
    fi
} 

function link_home() {
    print_msg DEBG "Link Home. Current position is $(pwd)"
    for file in "$(find . -type f -name "*.home")"
    do
        if [ -z $file ]
        then
            continue
        fi
        #Link this file to ~, removing extension, and hidden
        print_msg DEBG "For found file $file"
        local no_ext=${file%.home}
        local ok=.$no_ext
        print_msg DEBG "Got no_ext $no_ext , ok $ok"
    done

}

link_home
