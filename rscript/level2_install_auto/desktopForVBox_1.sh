#!/bin/bash
clear
# greeter
echo "$(tput setaf 1)] rscript: level 2: desktopForVBox$(tput setaf 7)"

# confirm
echo "$(tput setaf 1)] rscript: Info: Check 'About' to see how this script works$(tput setaf 7)"
read -p "$(tput setaf 7)] rscript: Press [Enter] key to continue...$(tput setaf 7)"

# continue
clear
echo "$(tput setaf 1)] rscript: Autoinstalling desktop for VBox... $(tput setaf 7)"


### pre-installation
echo "$(tput setaf 1)] rscript: Pre-installation... $(tput setaf 7)"
# 1.setting clock
echo "$(tput setaf 1)] rscript: 1.Setting clock... $(tput setaf 7)"
timedatectl set-ntp true
timedatectl status
# 2.partition
echo "$(tput setaf 1)] rscript: 2.Partitioning... $(tput setaf 7)"
# partitioning
parted /dev/sda mklabel gpt
parted /dev/sda mkpart efi fat32 1mb 301mb
parted /dev/sda mkpart swap linux-swap 301mb 2349mb
parted /dev/sda mkpart root ext4 2349mb 100%
parted /dev/sda set 1 boot on
# formating
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
# mounting
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2

### installation
echo "$(tput setaf 1)] rscript: Installation... $(tput setaf 7)"
# 3.installing linux
echo "$(tput setaf 1)] rscript: 3.Installing Linux... $(tput setaf 7)"
pacstrap /mnt base linux linux-firmware
# 4.generate fstab for drive
echo "$(tput setaf 1)] rscript: 4.Generate fstab... $(tput setaf 7)"
genfstab -U /mnt >> /mnt/etc/fstab
# 5.chroot
echo "$(tput setaf 1)] rscript: 5.Chroot... $(tput setaf 7)"
arch-chroot
echo "$(tput setaf 1)] $(tput setaf 7)"
echo "$(tput setaf 1)] rscript: Rerun RSCRIPT: desktopForVBox_2 $(tput setaf 7)"
echo "$(tput setaf 1)] $(tput setaf 7)"
