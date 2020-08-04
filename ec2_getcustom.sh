#!/bin/bash

if [ $USER = 'root' ]; then
    which git
    if [ $? -ne 0 ]; then
        yum -y install git
    fi
    git clone ssh://git@itrev.co.jp:60606/home/git/repos/custom.git /usr/local/share/custom
else
    echo this script must be run on root user
fi
