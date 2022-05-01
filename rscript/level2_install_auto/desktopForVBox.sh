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
echo "$(tput setaf 1)] rscript: Pre-instalatiion... $(tput setaf 7)"

# 1.setting clock
echo "$(tput setaf 1)] rscript: Setting clock... $(tput setaf 7)"
timedatectl set-ntp true
timedatectl status
