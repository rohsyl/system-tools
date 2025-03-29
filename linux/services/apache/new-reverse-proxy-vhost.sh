#!/bin/bash

# new-proxy-vhost: Automatic Apache2 Reverse Proxy generation script with optional HTTPS support


APACHE_SITES_AVAILABLE="/etc/apache2/sites-available"

if [ $# -lt 2 ]; then
    echo "Usage:"
    echo "  $0 [domain] [target_ip:port] [--https=true|false (optional)] [--ssl-path=/path/to/ssl (optional)]"
    echo ""
    echo "Example:"
    echo "  $0 plex.huser.network 192.168.10.217:32400 --https=true"
    exit 1
fi

domain=$1
target=$2
https=false # Valeur par défaut
SSL_CERT_PATH="/etc/letsencrypt/live/$domain" # Chemin SSL par défaut basé sur le nom du domaine

# Analyse les arguments supplémentaires
for arg in "$@"
do
    if [[ "$arg" == "--https=true" ]]; then
        https=true
    fi
    if [[ "$arg" =~ ^--ssl-path=.* ]]; then
        SSL_CERT_PATH="${arg#*=}"
    fi
done

# Vérification de la syntaxe target IP:port
if ! [[ $target =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$ ]]; then
    echo "Error: target must be in IP:PORT format (ex: 192.168.10.217:32400)"
    exit 1
fi

# Génération du fichier Apache2
conf_file="$APACHE_SITES_AVAILABLE/$domain.conf"

echo "Generating Apache reverse proxy config for $domain (HTTPS: $https)..."

if [ "$https" = true ]; then
cat > $conf_file <<EOF
<VirtualHost *:80>
    ServerName $domain

    RewriteEngine On
    RewriteRule ^/(.*)$ https://$domain/\$1 [R=301,L]
</VirtualHost>

<VirtualHost *:443>
    ServerName $domain
    ServerAdmin webmaster@$domain

    ProxyPreserveHost On
    ProxyRequests Off

    ProxyPass / https://$target/
    ProxyPassReverse / https://$target/

    Header always set Strict-Transport-Security "max-age=15552000"

    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined

    SSLEngine On
    Include /etc/letsencrypt/options-ssl-apache.conf
    SSLCertificateFile ${SSL_CERT_PATH}/fullchain.pem
    SSLCertificateKeyFile ${SSL_CERT_PATH}/privkey.pem
</VirtualHost>
EOF
    echo "Enabling Apache SSL module..."
    a2enmod ssl >/dev/null
else
cat > $conf_file <<EOF
<VirtualHost *:80>
    ServerName $domain
    ServerAdmin webmaster@$domain

    ProxyPreserveHost On
    ProxyRequests Off

    ProxyPass / http://$target/
    ProxyPassReverse / http://$target/

    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined
</VirtualHost>
EOF
fi

# Activer modules nécessaires
echo "Activating Apache proxy modules..."
a2enmod proxy >/dev/null
a2enmod proxy_http >/dev/null

# Activer le site
echo "Activating Apache site $domain..."
a2ensite "$domain.conf" >/dev/null

# Tester la config Apache puis reload
apache2ctl configtest
if [ $? -eq 0 ]; then
    echo "Configuration Apache OK, reloading..."
    systemctl reload apache2
    echo "✅ Reverse proxy for $domain → $target successfully active (HTTPS=$https)."
else
    echo "❌ Apache configuration failed. Please verify manually!"
fi
