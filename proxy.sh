#!/bin/bash

# Ensure the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Remove old I2P repository list, if it exists
rm -f /etc/apt/sources.list.d/i2p.list

# Install gnupg if it's not already installed
apt-get install -y gnupg

# Add I2P repository and key
echo "deb https://ppa.launchpadcontent.net/i2p-maintainers/i2p/ubuntu noble main" > /etc/apt/sources.list.d/i2p.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AB9660B9EB2CC88B

# Update package list and install the required packages
apt-get update
apt-get install -y secure-delete tor i2p i2p-router

# Build and install the kali-anonsurf package
dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb
dpkg -i kali-anonsurf.deb || (apt-get -f install -y && dpkg -i kali-anonsurf.deb)

# Verify installation of kali-anonsurf
if ! dpkg -l | grep -qw kali-anonsurf; then
    echo "The package 'kali-anonsurf' failed to install."
    exit 1
fi

echo "Installation completed successfully."
exit 0

