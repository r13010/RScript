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

continue_mess() {
options=("I did it, continue")
select opt in "${options[@]}"
do
    case $opt in
        "I did it, continue")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

# Menus
## Menu Install KVM KVMGPU
menu_installkvm_kvmgpu2() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install KVM: KVMGPU #3 Software
--------------------------------------------------------------------------------
"
echo -ne "  BE CAREFUL!
  You are about to go to the installation process,
  follow the steps shown here go passthrough your GPU to virtio.

  It's recommended that you've done it before (the manual way) so
  you don't break your system or smth.
  You will be asked questions throughout the installation.

"
options=("Continue" "Quit RSCRIPT")
select opt in "${options[@]}"
do
    case $opt in
        "Continue")
            # continue
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

# 12.Install pkgs
step12_installpkgs() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: Installing packages...
--------------------------------------------------------------------------------
"
pacman -S --noconfirm --needed qemu libvirt ovmf virt-manager ebtables iptables dnsmasq
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        If the software wasn't installed automatically, run:
        pacman -S --noconfirm --needed qemu libvirt ovmf virt-manager ebtables iptables dnsmasq
--------------------------------------------------------------------------------
"
continue_mess

}

# 13.Enabling services
step13_enablingservices() {

clear

systemctl start libvirtd.service
systemctl enable libvirtd.service
systemctl status libvirtd.service

systemctl start virtlogd.socket
systemctl enable virtlogd.socket
systemctl status virtlogd.socket

sudo sudo systemctl restart libvirtd
systemctl status libvirtd.service

virsh net-start default
virsh net-autostart default

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        If the services weren't enabled automatically, run in order:
        
        systemctl start libvirtd.service
        systemctl enable libvirtd.service

        systemctl start virtlogd.socket
        systemctl enable virtlogd.socket

        sudo sudo systemctl restart libvirtd

        virsh net-start default
        virsh net-autostart default 
--------------------------------------------------------------------------------
"
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        KVMGPU #3 Software is done!
        You should now be able to create a KVM in virt-manager and run it with
        the hijacked dedicated GPU
--------------------------------------------------------------------------------
"
}

### Define script logic
root_check
clear
menu_installkvm_kvmgpu2

step12_installpkgs
step13_enablingservices

