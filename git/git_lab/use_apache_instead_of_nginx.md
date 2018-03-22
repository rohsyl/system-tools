# 1. Stop GitLab services
```
$ sudo gitlab-ctl stop
```

# 2. Disable built-in Nginx
```
$ sudo nano /etc/gitlab/gitlab.rb

# Uncomment the web server external_users settings, and set both to www-data.
web_server['external_users'] = ['www-data']

# In the next section, “GitLab Nginx,” uncomment the first line and set it to false.
nginx['enable'] = false
```

# 3. Reconfigure GitLab
```
$ sudo gitlab-ctl reconfigure
```

# 4. Add virtual host for GitLab to Apache
- Create a new virtual host files with `plex_script/apache/newvhost.sh` and set his content to
```
    <VirtualHost *:80>
        ServerName gitlab.rohs.ch
        ServerSignature Off
    
        DocumentRoot /opt/gitlab/embedded/service/gitlab-rails/public
    
        ProxyRequests Off
        ProxyPreserveHost On
        AllowEncodedSlashes NoDecode
    
        ProxyPass / http://127.0.0.1:8080/
    
        ProxyPassReverse / http://127.0.0.1:8080/
    
        <Directory /opt/gitlab/embedded/service/gitlab-rails/public>
            # apache 2.2
            Order allow,deny
            Allow from all
    
            # apache 2.4
            Require all granted
        </Directory>
    
        <Location />
            Order deny,allow
            Allow from all
    
            Require all granted
        </Location>
    
        <Location /assets>
            Require all granted
            ProxyPass !
            ProxyPassReverse !
        </Location>
    
        RewriteEngine on
    
        RewriteCond %{REQUEST_URI} ^/api/v3/.*
        RewriteRule .* http://127.0.0.1:8181%{REQUEST_URI} [P,QSA,NE]
    
    
        RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f [OR]
        RewriteCond %{REQUEST_URI} ^/uploads/.*
        RewriteRule .* http://127.0.0.1:8080%{REQUEST_URI} [P,QSA]
        
        LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %b" common_forwarded
        ErrorLog  /var/log/apache2/gitlab_error.log
        CustomLog /var/log/apache2/gitlab_forwarded.log common_forwarded
        CustomLog /var/log/apache2/gitlab_access.log combined env=!dontlog
        CustomLog /var/log/apache2/gitlab.log combined
    </VirtualHost>
```

- Reload apache2
```
$ sudo systemctl restart apache2
```

# 5. Start GitLab services
```
$ sudo gitlab-ctl start
```