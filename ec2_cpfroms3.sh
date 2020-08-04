#!/bin/bash
export DOMAIN=                      # Input your domain name
#export DOMAIN=www.ukima2020.work   # <- Sample

export ZIPFILE=                     # Input zip filename to be copied from S3
#export ZIPFILE=page-one.zip        # <- Sample

export S3BUCKET=                    # Input your S3 bucket name
#export S3BUCKET=mitsubishichem-sys.co.jp.2020.inst01   # <- Sample

aws s3 cp s3://$S3BUCKET/$ZIPFILE .

if [ $? -ne 0 ]; then
    echo Error occured. Please check your configuration.
else
    USER=ec2-user
    DIRNAME=`echo $ZIPFILE | sed -e 's/\.zip$//g'`
    NGINXDIR=/usr/share/nginx/$DOMAIN/html

    unzip $ZIPFILE
    sudo chown -R $USER:$USER $NGINXDIR
    rm -rf $NGINXDIR/*
    mv $DIRNAME/* $NGINXDIR/
    sudo chown -R nginx:nginx $NGINXDIR
    rm -rf $DIRNAME*
fi
