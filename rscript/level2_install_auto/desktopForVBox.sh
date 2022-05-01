#!/bin/bash
clear
# greeter
echo "$(tput setaf 1)] rscript: level 2: desktopForVBox$(tput setaf 7)"

# confirm
echo "$(tput setaf 12)] rscript: Info: Check 'About' to see how this script works$(tput setaf 7)"
read -p "$(tput setaf 7)] rscript: Press [Enter] key to continue...$(tput setaf 7)"

# continue
clear
echo "$(tput setaf 1)] rscript: Autoinstalling desktop for VBox... $(tput setaf 7)"


### pre-installation
echo "$(tput setaf 1)] rscript: Pre-installation... $(tput setaf 7)"
# 1.setting clock
echo "$(tput setaf 12)] rscript: 1.Setting clock... $(tput setaf 7)"
timedatectl set-ntp true
timedatectl status
# 2.partition
echo "$(tput setaf 12)] rscript: 2.Partitioning... $(tput setaf 7)"
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
echo "$(tput setaf 12)] rscript: 3.Installing Linux... $(tput setaf 7)"
pacstrap /mnt base linux linux-firmware
# 4.generate fstab for drive
echo "$(tput setaf 12)] rscript: 4.Generate fstab... $(tput setaf 7)"
genfstab -U /mnt >> /mnt/etc/fstab
# 5.chroot
echo "$(tput setaf 12)] rscript: 5.Chroot... $(tput setaf 7)"
arch-chroot /mnt
pacman -S efibootmgr dosfstools openssh os-prober mtools linux-headers networkmanager nano git base-devel --noconfirm
# 6.timezone
echo "$(tput setaf 12)] rscript: 6.Timezone (auto for Bucharest)... $(tput setaf 7)"
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
# 7.localization
echo "$(tput setaf 12)] rscript: 7.Localization (auto for en-ro)... $(tput setaf 7)"
locale-gen
# keyboard layout
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ro_RO.UTF-8 UTF-8" >> /etc/locale.gen
# language
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# 8.hostname
echo "$(tput setaf 12)] rscript: 8.Hostname (auto for RsVirtualBox)... $(tput setaf 7)"
echo "RsVirtualBox" >> /etc/hostname
# 9.regen initramfs
echo "$(tput setaf 12)] rscript: 9.Regen initramfs... $(tput setaf 7)"
mkinitcpio -P
# 10.bootloader
echo "$(tput setaf 12)] rscript: 10.Grub2 bootloader... $(tput setaf 7)"
pacman -S grub --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=RsVbox /dev/sda
# 11.gui
echo "$(tput setaf 12)] rscript: 11.GUI (auto for KdePlasma)... $(tput setaf 7)"
pacman -S xorg plasma konsole sudo --noconfirm
systemctl enable sddm.service
# 12.gui
echo "$(tput setaf 12)] rscript: 12.User configurations... $(tput setaf 7)"
useradd -m r
nano /etc/sudoers // add user

### post-installation
echo "$(tput setaf 1)] rscript: Post manual installation... $(tput setaf 7)"
echo "$(tput setaf 12)] rscript: Info: run bash post.sh to display this $(tput setaf 7)"
echo "$(tput setaf 3)] rscript: Do this commands manually: $(tput setaf 7)"
echo " "
echo "$(tput setaf 3)] pacman -S amd-ucode $(tput setaf 7)// for amd cpu or $(tput setaf 7)"
echo "$(tput setaf 3)] pacman -S intel-ucode $(tput setaf 7)// for intel cpu $(tput setaf 7)"
echo "$(tput setaf 3)] grub-mkconfig -o /boot/grub/grub.cfg $(tput setaf 7)"
echo "$(tput setaf 3)] passwd $(tput setaf 7)// set root password$(tput setaf 7)"
echo "$(tput setaf 3)] passwd r $(tput setaf 7)// set r password$(tput setaf 7)"
echo "$(tput setaf 3)] reboot $(tput setaf 7)// and pray$(tput setaf 7)"

