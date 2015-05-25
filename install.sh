#!/bin/bash
echo "PufferPanel - Better Installer";
if [[ `id -u` -ne 0 ]] ; then echo "This installer can only be run as root." ; exit 1 ; fi
echo "Checking for dependencies...";
echo "" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
wget wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/dotdeb.gpg -O dotdeb.gpg
apt-key add dotdeb.gpg
rm -rf dotdeb.gpg
apt-get update
echo "Installing dependencies...";
apt-get install -y openssl curl apache2 git mysql-client mysql-server php5 php5-cli php5-curl php5-mysql php5-mcrypt wget
cd /tmp
PS3='Which package would you like to install?'
options=("Master (WWW)" "Slave (Scales)" "Master + Scales (WWW + Scales)" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "Master (WWW)")
            echo "Runnning installer for Master..."
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/master.sh -O master.sh
            chmod 755 /tmp/master.sh
            /tmp/master.sh 
            ;;
        "Slave (Scales)")
            echo "Runnning installer for Slave..."
            apt-get install -y lib32gcc1 htop screen openjdk-7-jre
			wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/slave.sh -O slave.sh
            chmod 755 /tmp/slave.sh
            /tmp/slave.sh
            ;;
        "Master + Scales (WWW + Scales)")
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/master.sh -O master.sh
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/slave.sh -O slave.sh
            chmod 755 /tmp/master.sh
            chmod 755 /tmp/slave.sh
            echo "Runnning installer for Master..."
            /tmp/master.sh
            echo ""
            echo "Runnning installer for Slave..."
            /tmp/slave.sh
            ;;
        "Cancel")
            break
            ;;
        *) echo Invalid option selected;;
    esac
done
echo "Installation complete! If you require more help, please visit http://www.pufferpanel.com/v0.8.0/docs for more information."