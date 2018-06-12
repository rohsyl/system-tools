#!/bin/bash

# This script remove virtual host.
# you should put it under /usr/local/bin/
# and run it with sudo newvhost

if [ $# -eq 0 ] 
then
	echo "No arguments supplied"
	echo "Type \"$0 --help\" for more informations"
	exit 0
fi

if [ $1 = "--help" ]
then
	echo "$0 [ SITE_NAME ]"
	echo "Remove virtual host in apache2 named SITE_NAME"
	exit 0
fi

www=/var/www/sites
sn=$1

echo Disable virtual host [OK]
a2dissite $sn >/dev/null

echo Restart apache service [OK]
service apache2 reload >/dev/null

echo Delete configuration file /etc/apache2/sites-available/$sn.conf [OK]
sudo rm /etc/apache2/sites-available/$sn.conf

echo Files are always available under $www/$sn [OK]