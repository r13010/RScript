#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup mirrors
mirrors() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 2-full-setup-mirrors
--------------------------------------------------------------------------------
"
# Refreshing mirrors
pacman -S --noconfirm --needed reflector curl rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

iso=$(curl -4 ifconfig.co/country-iso)
echo "RSCRIPT: Country detected: $iso"
echo "RSCRIPT: Starting reflector..."
reflector --country $iso --latest 200 --sort rate --save /etc/pacman.d/mirrorlist

sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Changing compression settings and makeflags
nc=$(grep -c ^processor /proc/cpuinfo)
TOTAL_MEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')

if [[  $TOTAL_MEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi
}

### Define script logic
mirrors