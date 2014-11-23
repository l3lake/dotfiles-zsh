#!/bin/bash
echo "------------------> Installing unzip curl wget build-essential python-software-properties..."
sudo apt-get -y install unzip vim curl wget build-essential python-software-properties

echo "------------------> Updating Ubuntu..."
sudo apt-get update

echo "------------------> Installing prereqs..."
sudo apt-get -y install ruby-dev rake exuberant-ctags ack-grep

echo "------------------> Installing Janus..."
curl -Lo- https://bit.ly/janus-bootstrap | bash

echo "------------------> Creating custom .janus directory"
mkdir ~/.janus
cd ~/.janus

echo "------------------> Installing xtra vim plugins"
sudo git clone https://github.com/bling/vim-airline
sudo git clone https://github.com/tpope/vim-surround
sudo git clone https://github.com/mattn/gist-vim
sudo git clone https://github.com/mattn/webapi-vim
sudo git clone https://github.com/tristen/vim-sparkup
sudo git clone https://github.com/nathanaelkane/vim-indent-guides
cd ~/

echo "------------------> Done"
