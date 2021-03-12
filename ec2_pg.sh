#!/bin/bash

# installing PostgreSQL Database
P=postgresql
yum -y install $P $P-devel $P-server $P-libs
su - postgres -c "initdb -E UTF8"
systemctl start postgresql

# create database, retrieve and import dummy data
wget https://be0.fit/ec2_pg.sql
cp ec2_pg.sql /tmp
su - postgres -c "psql -f /tmp/ec2_pg.sql"

rm -rf ec2_pg*
rm -rf /tmp/ec2_pg.sql
