#!/bin/bash
dist=`grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'`
RED='\033[0;31m'
NC='\033[0m'
printf "${RED}PufferPanel${NC} - Better Installer"
echo ""
if [[ `id -u` -ne 0 ]] ; then echo "This installer can only be run as root." ; exit 1 ; fi
if [ !"$dist" == "Ubuntu" ] || [ !"$dist" == "Debian" ]; then echo "This installer can only be run on Debian or Ubuntu" exit 1 ; fi
echo "Checking for dependencies..."
echo "" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg -O dotdeb.gpg >/dev/null 2>/dev/null
apt-key add dotdeb.gpg > /dev/null
rm -rf dotdeb.gpg 
apt-get update > /dev/null
echo "Installing dependencies...";
apt-get install -y openssl curl apache2 git php5 php5-cli php5-curl php5-mysql php5-mcrypt wget >/dev/null 2>/dev/null
echo "Installing MySQL..."
apt-get install -y mysql-client mysql-server
cd /tmp
clear
PS3='Which package would you like to install: '
options=("Master (WWW)" "Slave (Scales)" "Master + Scales (WWW + Scales)" "Cancel or Finish")
select opt in "${options[@]}"
do
    case $opt in
        "Master (WWW)")
            echo "Runnning installer for Master..."
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/master.sh -O master.sh >/dev/null 2>/dev/null
            chmod 755 /tmp/master.sh
            /tmp/master.sh 
            ;;
        "Slave (Scales)")
            echo "Runnning installer for Slave..."
            apt-get install -y lib32gcc1 htop screen openjdk-7-jre > /dev/null
			wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/slave.sh -O slave.sh >/dev/null 2>/dev/null
            chmod 755 /tmp/slave.sh
            /tmp/slave.sh
            ;;
        "Master + Scales (WWW + Scales)")
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/master.sh -O master.sh >/dev/null 2>/dev/null
            wget https://raw.githubusercontent.com/delta360/PufferPanel-Better-Installer/master/ifiles/slave.sh -O slave.sh >/dev/null 2>/dev/null
            chmod 755 /tmp/master.sh
            chmod 755 /tmp/slave.sh
            echo "Runnning installer for Master..."
            /tmp/master.sh
            echo ""
            echo "Runnning installer for Slave..."
            apt-get install -y lib32gcc1 htop screen openjdk-7-jre > /dev/null
            /tmp/slave.sh
            ;;
        "Cancel or Finish")
            break
            ;;
        *) echo Invalid option selected;;
    esac
    exit 1
done
echo "Installation complete! If you require more help, please visit http://www.pufferpanel.com/v0.8.0/docs for more information."