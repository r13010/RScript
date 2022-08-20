#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup mirrors
mirrors() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 2-full-setup-mirrors
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - What country are you in?
--------------------------------------------------------------------------------
"

options=("Romania" "USA" "Another")
select opt in "${options[@]}"
do
case $opt in
    "Romania")
        reflector --country romania --latest 200 --sort rate --save /etc/pacman.d/mirrorlist
        break
        ;;
    "USA")
        reflector --country usa --latest 200 --sort rate --save /etc/pacman.d/mirrorlist
        break
        ;;
    "Another")
        break
        ;;
    *) echo "Invalid option";;
    esac
done

}

### Define script logic
mirrors