#!/usr/bin/bash
service docker start

cat .ssh/users/* > .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

sed -i "s/#AuthorizedKeysFile/AuthorizedKeysFile/" /etc/ssh/sshd_config
service ssh start

git clone https://${GITHUB_TOKEN}@github.com/superbalist/cms.superbalist.com.git
git clone https://${GITHUB_TOKEN}@github.com/superbalist/superbalist-kubernetes.git

cd superbalist-kubernetes
git submodule init
sed -i "s#git@github.com#https://${GITHUB_TOKEN}@github.com#g" .git/config
sed -i "s#github.com:Superbalist#github.com/Superbalist#g" .git/config

git submodule update --recursive

git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=2678400'
git config --global user.email "garykrige@gmail.com"
git config --global user.naem "Gary Krige"

sleep infinity
