#!/bin/bash

# installing Python 3.7
#amazon-linux-extras -y install epel
#yum -y install spawn-fcgi fcgi-devel
#echo 'OPTIONS="-u nginx -g nginx -a 127.0.0.1 -p 9000 -P /var/run/spawn-fcgi.pid -- /usr/sbin/fcgiwrap"' >> /etc/sysconfig/spawn-fcgi
#yum -y install fcgiwrap

yum -y install python-pip
P=python3
yum -y install $P $P-libs $P-devel $P-setuptools $P-tkinter $P-pip 

#pip install pyleus virtualenv virtualenvwrapper djangorestframework django-debug-toolbar django-extensions django-settings-export gunicorn sphinx django-debug-toolbar --upgrade
pip install virtualenv virtualenvwrapper

PRF=ec2_python.profile
wget https://be0.fit/$PRF
PYTHON_REQ=ec2_python_requirement.txt
wget https://be0.fit/$PYTHON_REQ
cp $PYTHON_REQ /tmp/requirement.txt

D=/root
#cat $PRF >> $D/.bash_profile
echo "alias ng='su -s /bin/bash - nginx'" >> $D/.bashrc

D=/var/lib/nginx
cp /etc/skel/.bash_profile $D
cp /etc/skel/.bashrc $D
cat $PRF >> $D/.bash_profile
chown -R nginx:nginx $D

D=/home/ec2-user
#cat $PRF >> $D/.bash_profile
#chown -R ec2-user:ec2-user $D
echo "alias ng='sudo su -s /bin/bash - nginx'" >> $D/.bashrc

# retrieve python cgi files
#wget https://be0.fit/ec2_pythoncgi.tgz
#tar xvfz ec2_pythoncgi.tgz
#chown -R nginx:nginx cgi-bin
#mv cgi-bin `ls -1d /usr/share/nginx/www*`
#wget https://be0.fit/ec2_pythoncgi.conf
#CONF=`ls -1 /etc/nginx/conf.d/www*`
#sed -i -e '$d' $CONF
#cat ec2_pythoncgi.conf >> $CONF
#nginx -t
#if [ $? -eq 0 ]; then
#    systemctl restart nginx
#fi

rm -rf ec2_python*

