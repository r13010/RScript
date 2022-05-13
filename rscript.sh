#!/bin/bash

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/rscript/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/rscript/configs
set +a

# Greeter
bash $SCRIPTS_DIR/rsplash.sh
echo " "
echo "] RSCRIPT: Welcome"
echo " "
sleep 1s

# Create configuration
bash $SCRIPTS_DIR/rsplash.sh
echo " "
echo "] rscript: Starting installer..."
echo " "
sleep 1s
bash $SCRIPTS_DIR/0-startup.sh
