#!/bin/bash
echo "PufferPanel - Better Installer";
if [[ `id -u` -ne 0 ]] ; then echo "This installer can only be run as root." ; exit 1 ; fi
echo "Checking for dependencies...";
apt-get update
echo "Installing dependencies...";
apt-get install -y openssl curl apache2 git mysql-client mysql-server php5 php5-cli php5-curl php5-mysql php5-mcrypt
PS3='Please enter your choice: '
options=("Master (WWW)" "Slave (Scales)" "Master + Scales (WWW + Scales)" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "Master (WWW)")
            echo "you chose choice 1"
            ;;
        "Slave (Scales)")
			wget
            ;;
        "Master + Scales (WWW + Scales)")
            echo "you chose choice 3"
            ;;
        "Cancel")
            break
            ;;
        *) echo Invalid option selected;;
    esac
done