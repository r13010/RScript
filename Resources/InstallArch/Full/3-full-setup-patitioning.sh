#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup partitioning
partitioning() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 3-full-setup-partitioning
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed fdisk
fdisk -l

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current drive selected is /dev/$DRIVE. Is this correct?
--------------------------------------------------------------------------------
"
options=("Yes, DELETE ALL DATA from this drive and install Arch" "Choose another drive" "Wait, show me all my drives again")
select opt in "${options[@]}"
do
    case $opt in
        "Yes, DELETE ALL DATA from this drive and install Arch")
            break
            ;;
        "Choose another drive")
            read -rs -p "My desired partition is /dev/" DRIVE
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current drive selected is /dev/$DRIVE. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        "Wait, show me all my drives again")
            clear
            fdisk -l
            sleep 1s
            ;;
        *) echo "Invalid option";;
    esac
done

echo "RSCRIPT: The selected drive is $DRIVE"

}

### Define script logic
partitioning
choose_partition