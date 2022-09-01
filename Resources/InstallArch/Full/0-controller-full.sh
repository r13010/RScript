#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh
sleep 0.5s
clear

# Checks
root_check() {
    if [[ "$(id -u)" != "0" ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! This script must be run under the 'root' user!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

docker_check() {
    if awk -F/ '$2 == "docker"' /proc/self/cgroup | read -r; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Docker container is not supported!
--------------------------------------------------------------------------------
"
        exit 0
    elif [[ -f /.dockerenv ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Docker container is not supported!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

arch_check() {
    if [[ ! -e /etc/arch-release ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! This script must be run in Arch Linux!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

pacman_check() {
    if [[ -f /var/lib/pacman/db.lck ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Pacman is blocked!
              If not running remove /var/lib/pacman/db.lck.
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

background_checks() {

bash Resources/Others/rsplash.sh
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Background checks
--------------------------------------------------------------------------------
"
root_check
arch_check
pacman_check
docker_check

}
# Controller Full
controller_full() {

background_checks
bash Resources/InstallArch/Full/1-full-setup-network.sh
bash Resources/InstallArch/Full/2-full-setup-mirrors.sh
bash Resources/InstallArch/Full/3-full-setup-partitioning.sh
bash Resources/InstallArch/Full/4-full-setup-linux.sh

arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/2-full-setup-mirrors.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/5-full-setup-basesoftware.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/6-full-setup-microcode.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/7-full-setup-langntimezone.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/8-full-setup-hostname.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/9-full-setup-usernpass.sh
# 10-full-setup-yay.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/11-full-setup-bootloader.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/12-full-setup-kde.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/13-full-setup-drivers.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Full/14-full-finish.sh

}

# Menus
## Menu Install Arch Full
menu_installarch_full() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install Arch: Full
--------------------------------------------------------------------------------
"
echo -ne "  BE CAREFUL!
  You are about to go to the installation process.
  We recommend disconnecting the unused drives to prevent
  accidental data loss.
  You will be asked questions throughout the installation.

"
options=("Continue" "Quit RSCRIPT")
select opt in "${options[@]}"
do
    case $opt in
        "Continue")
            # Redirect to Full Installation Script
            controller_full
            break
            ;;
        "Quit RSCRIPT")
            bash Resources/Others/rsplash.sh
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Quitting...
--------------------------------------------------------------------------------
"
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

### Define script logic
menu_installarch_full