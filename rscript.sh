#!/bin/bash

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/rscript/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/rscript/configs
set +a

#echo "$(tput setaf 12)]$(tput setaf 7)"

# Greeter
bash $SCRIPTS_DIR/rsplash.sh
echo " "
echo "$(tput setaf 12)]] RSCRIPT: Welcome!$(tput setaf 7)"
echo " "
sleep 1s

# Create configuration - 0-startup
bash $SCRIPTS_DIR/rsplash.sh
echo " "
echo "$(tput setaf 12)]] rscript: Starting installer...$(tput setaf 7)"
echo " "
sleep 1s
bash $SCRIPTS_DIR/0-startup.sh

source $CONFIGS_DIR/setup.conf
# Preinstalling - 1-preinstall
bash $SCRIPTS_DIR/rsplash.sh
echo " "
echo "$(tput setaf 12)]] rscript: Preinstall...$(tput setaf 7)"
echo " "
sleep 1s
bash $SCRIPTS_DIR/1-preinstall.sh
