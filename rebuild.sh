#!/bin/bash

#必须使用sudo权限
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi

echo "请保证将软件源修改为网易163镜像 3s后开始安装"
sleep 3
cd ~

#更新源
sudo apt-get update

#安装必要的lib和工具
sudo apt-get install vim gcc g++ build-essential git
sudo apt-get install -y wget vim build-essential openssl libreadline6 libreadline6-dev libmysqlclient-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev libcurl4-openssl-dev autoconf automake libtool imagemagick libmagickwand-dev libpcre3-dev nodejs libpq-dev


#配置vim
rm -rf ~/.vim
git clone https://github.com/guochy2012/vim.git ~/.vim
cp ~/.vim/vimrc ~/.vimrc


#zsh
sudo apt-get install zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh

#Boost
sudo apt-get install libboost-all-dev

#muduo
sudo apt-get install cmake
sudo apt-get install libcurl4-openssl-dev libc-ares-dev
sudo apt-get install protobuf-compiler libprotobuf-dev 
git clone https://github.com/chenshuo/muduo.git
cd ./muduo
./build.sh -j2
./build.sh install
cd ..


#MySQL
sudo apt-get install mysql-server

#配置Ruby 搭建jekyll
\curl -L https://get.rvm.io | bash -s stable
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >>~/.zshrc
source ~/.zshrc
rvm -v
sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
rvm pkg install readline openssl
rvm install 2.0.0
rvm use 2.0.0 --default
ruby -v
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
gem sources -l
gem install jekyll


#PHP
sudo apt-get install apache2 mysql-server mysql-client php5 php5-gd php5-mysql
sudo chmod 777 /var/www/
sudo apt-get install phpmyadmin

#Java
sudo apt-get install openjdk-7-jdk

#
sudo apt-get install dos2unix

