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
menu_installkvm_kvmgpu0() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install KVM: KVMGPU #1 Enable virtualization
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

# 1.Bios settings
step1_biossettings() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        Make sure you have enabled VIRTUALIZATION and IOMMU
        in your BIOS settings.
        (SVM for AMD or Intel-V)
--------------------------------------------------------------------------------
"
continue_mess

}

# 2.Edit Grub params
step2_grubparams() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        LOCATION:
        sudo nano /etc/default/grub

        INFO:
        Edit Grub parameters, add here:
        GRUB_CMDLINE_LINUX_DEFAULT='quiet [here] ... ':

            amd_iommu=on kvm.ignore_msrs=1
                (for AMD procs)
            intel_iommu=on kvm.ignore_msrs=1
                (for Intel procs)

        The file should look like:
        ...
        GRUB_CMDLINE_LINUX_DEFAULT='quiet amd_iommu=on kvm.ignore_msrs=1 ... '
        ...
--------------------------------------------------------------------------------
"
continue_mess

}

# 3.Regen Grub
step3_regengrub() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: Regenerating Grub...
--------------------------------------------------------------------------------
"
sleep 1s
grub-mkconfig -o /boot/grub/grub.cfg

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        If Grub wasn't regenerated automatically, do it yourself so by running:
        grub-mkconfig -o /boot/grub/grub.cfg
--------------------------------------------------------------------------------
"
continue_mess

}

# 4.Check IOMMU
step4_checkiommu() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        The virtualization should be enabled after reboot
        You may now reboot:
        reboot now

        After reboot, to check if virtualization is enabled, run:
        dmesg | grep -i -e DMAR -e IOMMU 
--------------------------------------------------------------------------------
"
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
        INFO:
        KVMGPU #1 Enable virtualization is done!
        Next step: KVMGPU #2 Hijack
--------------------------------------------------------------------------------
"

}

### Define script logic
root_check
clear
menu_installkvm_kvmgpu0

step1_biossettings
step2_grubparams
step3_regengrub
step4_checkiommu
