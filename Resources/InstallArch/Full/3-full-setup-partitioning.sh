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

pacman -S --noconfirm --needed fdisk parted
fdisk -l
parted /dev/sda print devices
#
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
            parted /dev/sda print devices
            sleep 1s
            ;;
        *) echo "Invalid option";;
    esac
done

echo "RSCRIPT: The selected drive is /dev/$DRIVE"
sleep 1s
umount -A --recursive /mnt # Make sure everything is unmounted before we start

# Partition the drive as for UEFI or BIOS
if [[ ! -d "/sys/firmware/efi" ]]; then
    echo "RSCRIPT: System detected as BIOS"
    # BIOS SYSTEM
    parted /dev/$DRIVE print -s # Print it first
    echo "RSCRIPT: Making partition table msdos..."
    parted /dev/$DRIVE mklabel msdos -s # Make it msdos
    echo "RSCRIPT: Making swap partition..."
    parted /dev/$DRIVE mkpart "SWAP" linux-swap 1mb 4097mb -s # Make swap
    echo "RSCRIPT: Making root partition..."
    parted /dev/$DRIVE mkpart "ROOT" ext4 4098mb 100% -s # Make root

    DRIVE1=$DRIVE"1"
    DRIVE2=$DRIVE"2"
    DRIVE3=$DRIVE"3"

    echo "RSCRIPT: Formatting swap patition..."
    mkswap /dev/$DRIVE1 # Format swap
    echo "RSCRIPT: Formatting root patition..."
    mkfs.ext4 /dev/$DRIVE2 # Format root as ext4

    echo "RSCRIPT: Mounting partitions..."
    mount /dev/$DRVIE2 /mnt
    swapon /dev/$DRIVE1

    parted /dev/$DRIVE print -s # Print it again
else
    echo "RSCRIPT: System detected as UEFI"
    # UEFI SYSTEM
    parted /dev/$DRIVE print -s # Print it first
    echo "RSCRIPT: Making partition table gpt..."
    parted /dev/$DRIVE mklabel gpt -s # Make it gpt
    echo "RSCRIPT: Making efi partition..."
    parted /dev/$DRIVE mkpart "EFI" fat32 1mb 301mb -s # Make efi
    parted /dev/$DRIVE set 1 boot on -s
    echo "RSCRIPT: Making swap partition..."
    parted /dev/$DRIVE mkpart "SWAP" linux-swap 301mb 4397mb -s # Make swap
    echo "RSCRIPT: Making root partition..."
    parted /dev/$DRIVE mkpart "ROOT" ext4 4397mb 100% -s # Make root

    DRIVE1=$DRIVE"1"
    DRIVE2=$DRIVE"2"
    DRIVE3=$DRIVE"3"

    echo "RSCRIPT: Formatting efi patition..."
    mkfs.fat -F 32 /dev/$DRIVE1 # Format efi
    echo "RSCRIPT: Formatting swap patition..."
    mkswap /dev/$DRIVE2 # Format swap
    echo "RSCRIPT: Formatting root patition..."
    mkfs.ext4 /dev/$DRIVE3 # Format root as ext4

    echo "RSCRIPT: Mounting partitions..."
    mount /dev/$DRVIE3 /mnt
    mount --mkdir /dev/$DRIVE1 /mnt/boot
    swapon /dev/$DRIVE2

    parted /dev/$DRIVE print -s # Print it again
fi

}

### Define script logic
partitioning
