#!/bin/bash

### continue
pacman -S efibootmgr dosfstools openssh os-prober mtools linux-headers networkmanager nano git base-devel --noconfirm
# 6.timezone
echo "$(tput setaf 1)] rscript: 6.Timezone (auto for Bucharest)... $(tput setaf 7)"
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
# 7.localization
echo "$(tput setaf 1)] rscript: 7.Localization (auto for en-ro)... $(tput setaf 7)"
locale-gen
# keyboard layout
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ro_RO.UTF-8 UTF-8" >> /etc/locale.gen
# language
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# 8.hostname
echo "$(tput setaf 1)] rscript: 8.Hostname (auto for RsVirtualBox)... $(tput setaf 7)"
echo "RsVirtualBox" >> /etc/hostname
# 9.regen initramfs
echo "$(tput setaf 1)] rscript: 9.Regen initramfs... $(tput setaf 7)"
mkinitcpio -P
# 10.bootloader
echo "$(tput setaf 1)] rscript: 10.Grub2 bootloader... $(tput setaf 7)"
pacman -S grub --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=RsVbox /dev/sda
# 11.gui
echo "$(tput setaf 1)] rscript: 11.GUI (auto for KdePlasma)... $(tput setaf 7)"
pacman -S xorg plasma konsole sudo --noconfirm
systemctl enable sddm.service
# 12.gui
echo "$(tput setaf 1)] rscript: 12.User configurations... $(tput setaf 7)"
useradd -m r
echo "r ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "$(tput setaf 1)] $(tput setaf 7)"
echo "$(tput setaf 1)] rscript: Rerun RSCRIPT: desktopForVBox_3 $(tput setaf 7)"
echo "$(tput setaf 1)] $(tput setaf 7)"


