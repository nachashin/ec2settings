#!/bin/bash
amazon-linux-extras install -y nginx1.12
systemctl enable nginx
systemctl start nginx
wget https://be0.fit/ec2_nginx.html
/bin/cp ec2_nginx.html /usr/share/nginx/html/index.html
rm -rf ec2*
