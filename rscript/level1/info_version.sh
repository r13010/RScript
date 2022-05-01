#!/bin/bash
clear
# print out the version of rscript
echo "$(tput setaf 12)] rscript: Info: Version beta 0.1010522a$(tput setaf 7)"

# returning...
read -p "$(tput setaf 7)] rscript: Press [Enter] key to return level 0...$(tput setaf 7)"
bash rscript_mgr.sh
