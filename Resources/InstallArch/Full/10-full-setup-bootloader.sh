#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup bootloader
bootloader() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 10-full-setup-bootloader
--------------------------------------------------------------------------------
"

DRIVE=sda
# Ask for the drive name
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current drive selected is /dev/$DRIVE. Is this correct?
--------------------------------------------------------------------------------
"
options=("Yes, install Grub to it" "Choose another drive" "Wait, show me all my drives again")
select opt in "${options[@]}"
do
    case $opt in
        "Yes, install Grub to it")
            break
            ;;
        "Choose another drive")
            read -rs -p "My desired drive is /dev/" DRIVE
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current drive selected is /dev/$DRIVE. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        "Wait, show me all my drives again")
            clear
            fdisk -l
            echo " "
            parted /dev/sda print devices
            sleep 1s
            ;;
        *) echo "Invalid option";;
    esac
done

echo "RSCRIPT: The selected drive is /dev/$DRIVE"
sleep 1s

# Install Grub
if [[ ! -d "/sys/firmware/efi" ]]; then
    echo "RSCRIPT: System detected as BIOS..."
    echo "RSCRIPT: Installing Grub..."
    # BIOS SYSTEM
    grub-install --target=i386-pc /dev/$DRIVE
else
    echo "RSCRIPT: System detected as UEFI..."
    echo "RSCRIPT: Installing Grub..."
    # UEFI SYSTEM
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ArchLinux /dev/$DRIVE
fi
}

### Define script logic
bootloader