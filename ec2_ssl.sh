#!/bin/bash

Usage () {
    cat << EOS
Usage: `basename $0`  [41mドメイン名[0m

host [41mドメイン名[0m で、今設定しているEC2インスタンスのIPアドレスが表示されることを確認して下さい
EOS

if [ ! -z "$1" ]; then
    echo "$1"
fi
}

if [ -z "$1" ]; then
    Usage
else
    DNSIP=`host $1 | grep -v mail | sed -e 's/^.*address //g'`
    MYIP=`curl -s http://checkip.dyndns.org | sed -e 's/^.*Address: //g' -e 's/<\/body.*$//g'`
    echo "DNSIP: $DNSIP"
    echo "MYIP : $MYIP"
    if [ "$DNSIP" = "$MYIP" ]; then
        cd /root/init
        #wget https://be0.fit/certbot-auto
        #chmod a+x certbot-auto
        certbot certonly --webroot -w /usr/share/nginx/html -d $1 -m root@$1 -n --agree-tos --debug
        cd /etc/nginx

#        BUP=nginx.conf_orig
#        if [ ! -f $BUP ]; then
#            mv nginx.conf $BUP
#            cat << EOS > nginx.conf
## For more information on configuration, see:
##   * Official English Documentation: http://nginx.org/en/docs/
##   * Official Russian Documentation: http://nginx.org/ru/docs/
#
#user nginx;
#worker_processes auto;
#error_log /var/log/nginx/error.log;
#pid /run/nginx.pid;
#
## Load dynamic modules. See /usr/share/nginx/README.dynamic.
#include /usr/share/nginx/modules/*.conf;
#
#events {
#    worker_connections 1024;
#}
#
#http {
#    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
#                      '\$status \$body_bytes_sent "\$http_referer" '
#                      '"\$http_user_agent" "\$http_x_forwarded_for"';
#
#    access_log  /var/log/nginx/access.log  main;
#
#    sendfile            on;
#    tcp_nopush          on;
#    tcp_nodelay         on;
#    keepalive_timeout   65;
#    types_hash_max_size 2048;
#
#    include             /etc/nginx/mime.types;
#    default_type        application/octet-stream;
#
#    # Load modular configuration files from the /etc/nginx/conf.d directory.
#    # See http://nginx.org/en/docs/ngx_core_module.html#include
#    # for more information.
#    include /etc/nginx/conf.d/*.conf;
#}
#EOS
#        fi 

        cd /etc/nginx/conf.d
        cat << EOS > $1.conf
server {
    listen      80;
    server_name $1;

    access_log  /var/log/nginx/$1-access.log  main;
    error_log   /var/log/nginx/$1-error.log  warn;

    location ~ ^/.well-known/ {
        root    /usr/share/nginx/$1/html;
    }

    location ~ ^/(.*)\$ {
        return https://$1;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/$1/html;
    }

}

server {
    listen      443 ssl;
    server_name $1;

    access_log  /var/log/nginx/$1-ssl-access.log  main;
    error_log   /var/log/nginx/$1-ssl-error.log  warn;

    proxy_set_header Host               \$http_host;
    proxy_set_header X-Real-IP          \$remote_addr;
    proxy_set_header X-Forwarded-Host   \$host;
    proxy_set_header X-Forwarded-Server \$host;
    proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;

    ssl_certificate /etc/letsencrypt/live/$1/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$1/privkey.pem;

    location / {
        root   /usr/share/nginx/$1/html;
        index  index.html index.htm index.php;
    }
}
EOS
        cd /usr/share/nginx
        mkdir $1
        cp -a html $1
        sed -i -e "s/SAMPLE PAGE/$1/g" /usr/share/nginx/$1/html/index.html
        chown -R nginx:nginx /usr/share/nginx
        nginx -t
        systemctl restart nginx.service
        cd
        rm -rf ec2*

    else
        Usage "[33;1m実行中のEC2インスタンスのIPアドレスと、$1 ドメインのIPアドレスが一致しません[0m"
    fi
fi
