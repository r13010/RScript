#!/bin/bash
clear
# print out the version of rscript
echo "$(tput setaf 12)] rscript: Info: Rscript_instmgr is an open-source shell-script based menu used for installing Arch Linux in an easier manner.$(tput setaf 7)"
echo "$(tput setaf 12)] rscript: Info: Made easier to use, understand or modify for your needs, fork it!$(tput setaf 7)"
echo "$(tput setaf 12)$(tput setaf 7)"
echo "$(tput setaf 12)] rscript: Info: Rscript_instmgr - truly simple, flexible, modular!$(tput setaf 7)"
echo "$(tput setaf 12)] rscript: Info: https://github.com/r13010/Rscript_instmgr$(tput setaf 7)"

# returning...
read -p "$(tput setaf 7)] rscript: Press [Enter] key to return to level 0...$(tput setaf 7)"
bash rscript_mgr.sh

