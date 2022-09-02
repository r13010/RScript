#!/bin/bash

# Splash 
bash Resources/Others/rsplash.sh
sleep 0.5s
clear

# Tweak_ShortShutdown
tweak1() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Tweak_ShortShutdown
        Faster systemd shutdown
--------------------------------------------------------------------------------
"

# Modify systemd params
sed -i 's/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: Done!
--------------------------------------------------------------------------------
"

}

### Define script logic
tweak1