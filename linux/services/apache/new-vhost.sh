#!/bin/bash

# newvhost: Create virtual hosts in Apache2 quickly and safely
# Place it under /usr/local/bin/ and run with sudo newvhost

APACHE_SITES_AVAILABLE="/etc/apache2/sites-available"
WWW="/var/www/sites"

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Type \"$0 --help\" for more information"
    exit 1
fi

if [ "$1" = "--help" ]; then
    echo "Usage:"
    echo "  $0 [SITE_NAME] [PATH_TO_DATA (optional)]"
    echo ""
    echo "Example:"
    echo "  $0 example.com"
    echo "  $0 example.com /path/to/public_html"
    exit 0
fi

sitename=$1

if [ "$2" ]; then
    site_dir=$2
else
    site_dir="$WWW/$sitename/public_html"
fi

echo "Creating Apache config file at $APACHE_SITES_AVAILABLE/$sitename.conf..."

cat > $APACHE_SITES_AVAILABLE/$sitename.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$sitename
    ServerName $sitename
    DocumentRoot $site_dir

    ErrorLog \${APACHE_LOG_DIR}/$sitename-error.log
    CustomLog \${APACHE_LOG_DIR}/$sitename-access.log combined

    <Directory "$site_dir">
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Ensure required modules
echo "Ensuring Apache2 rewrite module is enabled..."
a2enmod rewrite >/dev/null

# Create directories
echo "Creating directories at $site_dir..."
mkdir -p "$site_dir"

# Enable site
echo "Enabling new virtual host $sitename..."
a2ensite $sitename >/dev/null

# Check config and reload safely
apache2ctl configtest
if [ $? -eq 0 ]; then
    echo "Apache configuration OK, reloading Apache2..."
    systemctl reload apache2
else
    echo "Apache configuration FAILED. Please review manually."
fi

# Permissions (secure)
echo "Setting secure permissions..."
chown -R www-data:www-data "$WWW/$sitename"
chmod -R 750 "$WWW/$sitename"

echo "Your new site $sitename is now available!"
