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
menu_installkvm_kvmgpu1() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install KVM: KVMGPU #2 Hijack
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

# 5.GPU ID
step5_gpuid() {

clear

shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        You need to take the IDs of the devices that belong to your GPU
        and note them somewhere

        If you can't see your IDs, RUN IN BASH:
        shopt -s nstep5_gpuidl the IDs from a group
        - If your GPU is in a group with other devices, your motherboard 
        grouping is fked (bad)
          On boards like 'gigabyte b450m ds3h' the first x16 pcie slot is
        directly connected to the CPU so is grouped separately (good). The
        second x16 pcie slot is slaved to the chipset so the slot is grouped
        with all the devices bounded to the chipset (bad). Make sure your GPU
        is in the correct slot so it's grouped accordingly

        The IDs look like:
        Device [id:id]
--------------------------------------------------------------------------------
"
continue_mess

}

# 6.Hijack
step6_hijack() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        LOCATION:
        sudo nano /etc/modprobe.d/vfio.conf

        INFO:
        Hijack the IDs to make them passthrough the kernel
        Fill file with:
            
            options vfio-pci ids=
            
        And then add the IDs (like id:id,id:id,id:id)

        The file should look like:
        options vfio-pci ids=id:id,id:id        
--------------------------------------------------------------------------------
"
continue_mess

}

# 7.Ignore MSRS
step7_ignoremsrs() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        LOCATION:
        sudo nano /etc/modprobe.d/ignore_msrs.conf

        INFO:
        Add ignore to msrs
        Fill file with:
            
            options kvm ignore_msrs=1

        The file should look like:
        options kvm ignore_msrs=1      
--------------------------------------------------------------------------------
"
continue_mess

}

# 8.Adjust modules
step8_adjustmodules() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        LOCATION:
        sudo nano /etc/mkinitcpio.conf

        INFO:
        Adjust modules, add here:
        MODULES='[here]'

            vfio_pci vfio vfio_iommu_type1 vfio_virqfd

        And check for HOOKS param to contain 'modconf'
        HOOKS=' ... modconf ... '

        The file should look like:
        ...
        MODULES='vfio_pci vfio vfio_iommu_type1 vfio_virqfd'
        ...
        HOOKS=' ... modconf ... '
        ...
--------------------------------------------------------------------------------
"
continue_mess

}

# 9.Blacklist Diver
step9_blacklistdriver() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        LOCATION:
        sudo nano /etc/modprobe.d/blacklist-gpudriver.conf

        INFO:
        Blacklist the old driver in use, just in case (the driver for that
        card should be already uninstalled not to interfere with the vfio, but
        if anything happens and it's not working make this anyway)
        Add:

            blacklist amdgpu

        (or for nouveau and nvidia
        blacklist nouveau
        blacklist nvidia
        options nouveau modeset=0
        etc etc)

        The file should look like:
        blacklist amdgpu
--------------------------------------------------------------------------------
"
continue_mess

}

# 10.Regen Initramfs
step10_regeninitramfs() {

clear
mkinitcpio -P
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        If initramfs wasn't regenerated automatically, do it yourself so by running:
        mkinitcpio -P
--------------------------------------------------------------------------------
"
continue_mess

}

# 11.Check hijack
step11_checkhijack(){

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        The GPU should be hijacked after reboot. The card shouldn't give out
        any signal anymore
        You may now reboot:
        reboot now

        After reboot, to check if the GPU is hijacked, run:
        lspci -nnk
        You should see that the card is run by vfio-pci driver
--------------------------------------------------------------------------------
"
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        KVMGPU #2 Hijack is done!
        Next step: KVMGPU #3 Software
--------------------------------------------------------------------------------
"

}

### Define script logic
root_check
clear
menu_installkvm_kvmgpu1

step5_gpuid
step6_hijack
step7_ignoremsrs
step8_adjustmodules
step9_blacklistdriver
step10_regeninitramfs
step11_checkhijack

