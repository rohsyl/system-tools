#!/bin/bash

# This script creates virtual hosts.
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
	echo "Create new virtual host in apache2 named SITE_NAME"
	exit 0
fi

www=/var/www/sites
sn=$1

# Create the file with VirtualHost configuration in /etc/apache2/site-available/
echo "<VirtualHost *:80>
    ServerAdmin webmaster@$sn
	ServerName $sn
	DocumentRoot $www/$sn/public_html
	ErrorLog $www/$sn/logs/error.log 
	CustomLog $www/$sn/logs/access.log combined
	
	<Directory $www/$sn/public_html>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		allow from all
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$sn.conf

#Create diretory
mkdir $www/$sn
mkdir $www/$sn/public_html
mkdir $www/$sn/logs

# Enable the site
a2ensite $sn


# Reload Apache2
service apache2 reload

echo "Your new site is available $sn"
