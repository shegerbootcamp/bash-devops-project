#!/bin/bash

##
# Script to set up log rotation for NGINX logs
##

# Create logrotate configuration file for NGINX
logrotate_conf="/etc/logrotate.d/nginx"

cat <<EOL > $logrotate_conf
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data adm
    sharedscripts
    postrotate
        [ -s /run/nginx.pid ] && kill -USR1 \$(cat /run/nginx.pid)
    endscript
}
EOL

# Force logrotate to run immediately
logrotate -f $logrotate_conf

echo "Log rotation for NGINX logs has been set up and forced."
