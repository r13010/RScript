#!/bin/bash

### post-installation
echo "$(tput setaf 1)] rscript: Post manual installation... $(tput setaf 7)"
echo "$(tput setaf 1)] rscript: Info: Rerun RSCRIPT: desktopForVBox_3 to display this $(tput setaf 7)"
echo "$(tput setaf 3)] rscript: Do this commands manually: $(tput setaf 7)"
echo " "
echo "$(tput setaf 3)] pacman -S amd-ucode $(tput setaf 7)// for amd cpu or $(tput setaf 7)"
echo "$(tput setaf 3)] pacman -S intel-ucode $(tput setaf 7)// for intel cpu $(tput setaf 7)"
echo "$(tput setaf 3)] grub-mkconfig -o /boot/grub/grub.cfg $(tput setaf 7)"
echo "$(tput setaf 3)] passwd $(tput setaf 7)// set root password$(tput setaf 7)"
echo "$(tput setaf 3)] passwd r $(tput setaf 7)// set r password$(tput setaf 7)"
echo "$(tput setaf 3)] reboot $(tput setaf 7)// and pray$(tput setaf 7)"
