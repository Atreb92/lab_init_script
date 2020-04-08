#!/bin/bash

#
# This script has been written under ubuntu 19.10 to download and install the needed
# software for the Innovatvive Cmmunication Systems Laboratory
#

###############################################################################
# Update our machine to the latest code if we need to.

if [ "$(id -u)" -ne 0 ]; then
    echo 'This script must be run with root/sudo privileges' >&2
    exit 1
fi

apt update && apt upgrade -y

if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required in order to proceed with the install." >&2
    echo "Please reboot and re-run this script to finish the install." >&2
    exit 1
fi

echo "Which IDE would you like to install?"
echo "1. Netbeans"
echo "2. Eclipse"
echo "3. IntelliJ idea community edition"
echo ""
echo -n "Choose 1, 2 or 3: " 
read ideChoice

while [ $ideChoice != 1 -a $ideChoice != 2 -a $ideChoice != 3 ]
do
    echo -n "Invalid input, choose 1, 2 or 3: "
    read ideChoice
done

case $ideChoice in
    1)
    echo "Netbeans will be installed"
    apt-get install -y netbeans
    ;;
    2)
    echo "Eclipse will be installed"
    snap install --classic eclipse
    ;;
    3)
    echo "IntelliJ idea community edition will be installed"
    snap install --classic intellij-idea-community
    ;;
esac

apt-get install -y openjdk-13-jdk nodejs mosquitto mongodb-clients mongodb npm

npm install -g --unsafe-perm node-red

echo "Install is complete."
