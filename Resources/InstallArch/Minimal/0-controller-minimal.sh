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
# Controller minimal
controller_minimal() {

background_checks
bash Resources/InstallArch/Minimal/1-minimal-setup-network.sh
bash Resources/InstallArch/Minimal/2-minimal-setup-mirrors.sh
bash Resources/InstallArch/Minimal/3-minimal-setup-partitioning.sh
bash Resources/InstallArch/Minimal/4-minimal-setup-linux.sh

arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/2-minimal-setup-mirrors.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/5-minimal-setup-basesoftware.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/6-minimal-setup-microcode.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/7-minimal-setup-langntimezone.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/8-minimal-setup-hostname.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/9-minimal-setup-usernpass.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/10-minimal-setup-bootloader.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/11-minimal-setup-drivers.sh
arch-chroot /mnt bash /home/RScript/Resources/InstallArch/Minimal/12-minimal-finish.sh

}

# Menus
## Menu Install Arch Full
menu_installarch_minimal() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install Arch: Minimal
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
            # Redirect to Minimal Installation Script
            controller_minimal
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
menu_installarch_minimal