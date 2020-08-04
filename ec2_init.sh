#!/bin/bash
cd

# パッケージ追加
yum -y groupinstall Base "Development Tools"
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
yum -y install lynx

# ローカルタイム設定
ln -sf /usr/share/zoneinfo/Japan /etc/localtime

# ハードウェアクロック設定
sed -i "s/\"UTC\"/\"Japan\"/g" /etc/sysconfig/clock

# 文字コード設定
#sed -i "s/en_US\.UTF-8/ja_JP\.UTF-8/g" /etc/sysconfig/i18n
#echo "locale: ja_JP.UTF-8" >> /etc/cloud/cloud.cfg

# .*rcファイルなど取得＆設定
TGZ=ec2_init.tgz
wget https://be0.fit/$TGZ
tar xvfz $TGZ
for f in .bashrc .exrc .inputrc .screenrc .vimrc
do
    /bin/cp ec2/skel/$f /root
    /bin/cp ec2/skel/$f /home/ec2-user
    /bin/cp ec2/skel/$f /etc/skel
done
#echo "export LANG=ja_JP.UTF-8" >> /root/.bash_profile

# ツール等コピー
/bin/cp ec2/usr/local/bin/* /usr/local/bin

# 公開鍵設定
cat ec2/authorized_keys >> /home/ec2-user/.ssh/authorized_keys
chown -R ec2-user:ec2-user /home/ec2-user

# 後始末
rm -rf ec2*
