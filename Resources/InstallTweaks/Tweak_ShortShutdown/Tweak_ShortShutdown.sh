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

# Tweak_ShortShutdown
tweak1() {
root_check

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Tweak_ShortShutdown
    
    Desc:
        Faster systemd shutdown
        THIS TWEAK REQUIRES ROOT
--------------------------------------------------------------------------------
"
sleep 1s

# Modify systemd params
cp /etc/systemd/system.conf /etc/systemd/system_backup.conf
sed -i 's/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf

echo "RSCRIPT: Done!"

}

### Define script logic
tweak1