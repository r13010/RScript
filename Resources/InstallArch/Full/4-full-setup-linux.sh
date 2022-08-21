#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh


# Setup firmware
firmware() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 4-full-setup-linux
--------------------------------------------------------------------------------
"

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

# Unpack Linux
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Copy RScript to arch-chroot
arch-chroot /mnt pacman -S --noconfirm --needed git
arch-chroot /mnt git clone https://github.com/r13010/RScript /home/RScript
echo "RSCRIPT: rscript copied to home directory"

}

### Define script logic
firmware