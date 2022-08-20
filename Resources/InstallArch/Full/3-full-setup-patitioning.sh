#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup partitioning

choose_partition() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Write the drive you want to install to:
--------------------------------------------------------------------------------
"
read -rs -p "My desired partition is /dev/" DRIVE
echo "RSCRIPT: The selected drive is $DRIVE"


}

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
    RSCRIPT: Arch needs to be installed to a drive, you now can:
--------------------------------------------------------------------------------
"
options=("Choose a drive" "Wait, show me all my drives again")
select opt in "${options[@]}"
do
    case $opt in
        "Choose a drive")
            break
            ;;
        "Wait, show me all my drives again")
            fdisk -l
            sleep 1s
            ;;
        *) echo "Invalid option";;
    esac
done

}

### Define script logic
partitioning
choose_partition