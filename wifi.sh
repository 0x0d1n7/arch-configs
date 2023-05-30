#!/bin/bash

# Remove existing broadcom-wl package
sudo pacman -Rns broadcom-wl

# Create and edit the broadcom-wl-dkms.conf file
sudo tee /etc/modprobe.d/broadcom-wl-dkms.conf > /dev/null << EOF
blacklist b43
blacklist b43legacy
blacklist bcm43xx
blacklist bcma
blacklist brcm80211
blacklist brcmfmac
blacklist brcmsmac
blacklist ssb
EOF

# Install linux-headers and broadcom-wl-dkms
sudo pacman -Syu linux-headers broadcom-wl-dkms

# Regenerate the initramfs
sudo mkinitcpio -p linux
