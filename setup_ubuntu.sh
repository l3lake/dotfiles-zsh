#!/bin/bash
# ================================================================== #
# Ubuntu 14.04 web server build shell script
# ================================================================== #
# Parts copyright (c) 2012 Matt Thomas http://betweenbrain.com
# This script is licensed under GNU GPL version 2.0 or above
# ================================================================== #
#
#
#
#                              VARIABLES                             #
#
HOSTNAME=
SYSTEMIP=
DOMAIN=
USER=
PUBLICKEY="ssh-rsa ... foo@bar.com"
#
#
#                            END VARIABLES                           #
#
#
#
echo
echo
echo
echo "First things first, let's make sure we have the latest updates."
echo "---------------------------------------------------------------"
#
apt-get update && apt-get upgrade -y
echo
echo
echo
echo "Setting the hostname."
# http://library.linode.com/getting-started
echo "---------------------------------------------------------------"
echo
echo
#
echo "$HOSTNAME" > /etc/hostname
hostname -F /etc/hostname
echo
echo
echo
echo "Updating /etc/hosts."
echo "---------------------------------------------------------------"
#
cp /etc/hosts /etc/hosts.bak
#
echo "
127.0.0.1       localhost
127.0.1.        $HOSTNAME             $HOSTNAME
$SYSTEMIP       $HOSTNAME.$DOMAIN     $HOSTNAME
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
" >> /etc/hosts
echo
echo
echo
echo "Setting the proper timezone."
echo "---------------------------------------------------------------"
#
dpkg-reconfigure tzdata
echo
echo
echo
echo "Creating new primary user"
echo "---------------------------------------------------------------"
#
# Script to add a user to Linux system
#
# Copyright (c) 2007 nixCraft project <http://bash.cyberciti.biz/>
# This script is licensed under GNU GPL version 2.0 or above
# Comment/suggestion: <vivek at nixCraft DOT com>
#
# See url for more info:
# http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
#
if [ $(id -u) -eq 0 ]; then
    # read -p "Enter username of who can connect via SSH: " USER
    read -s -p "Enter password of user who can connect via SSH: " PASSWORD
    egrep "^$USER" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$USER exists!"
        exit 1
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $PASSWORD)
        useradd -s /bin/bash -m -d /home/$USER -U -p $pass $USER
        [ $? -eq 0 ] && echo "$USER has been added to system!" || echo "Failed to add a $USER!"
    fi
else
    echo "Only root may add a user to the system"
    exit 2
fi
#
# End script to add a user to Linux system
#
#
echo
echo
echo
echo "Adding $USER to SSH AllowUsers"
echo "---------------------------------------------------------------"
#
echo "AllowUsers $USER" >> /etc/ssh/sshd_config
#
echo
echo
echo
echo "Backing up sudoers file to /etc/sudoers.bak"
echo "---------------------------------------------------------------"
cp /etc/sudoers /etc/sudoers.bak
echo
echo
echo
echo "Adding $USER to sudoers"
echo "---------------------------------------------------------------"
#
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
echo "$USER    ALL=(ALL) ALL" >> /etc/sudoers.tmp
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers
#
echo
echo
echo
echo "Adding ssh key"
echo "---------------------------------------------------------------"
#
mkdir /home/$USER/.ssh
touch /home/$USER/.ssh/authorized_keys
echo $PUBLICKEY >> /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
#
sed -i "s/#AuthorizedKeysFile/AuthorizedKeysFile/g" /etc/ssh/sshd_config
#
/etc/init.d/ssh restart
#echo
#echo
#echo
#echo "Adding a bit of color and formatting to the command prompt"
## http://ubuntuforums.org/showthread.php?t=810590
#echo "---------------------------------------------------------------"
##
#echo '
##export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]➜\[\033[01;34m\]\w\[\033[00m\]\» "
#export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]➜ \[\033[01;34m\]\w\[\033[00m\] » "
##export PS1="%{$fg_no_bold[cyan]%}%n%{$fg_no_bold[magenta]%}➜%{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}» "
#' >> /home/$USER/.bashrc
#source /home/$USER/.bashrc
#
# ================================================================== #
#                              install docker                        #
# ================================================================== #
#
# # install docker
# curl -ssl https://get.docker.io/ubuntu/ | sudo sh
#
# # copy dotfiles
# git clone http://git.blakekanderson.com/blake/dotfiles.git /home/$USER/dotfiles
#
# # install setup
# bash /home/$USER/dotfiles/install/vimsetup.sh
#
# # move config files into root dir
# ln -s /home/$USER/dotfiles/.* /home/$USER/
# rm -rf /home/$USER/.git
#
#
#
echo
echo
echo
echo "One final hurrah"
echo "--------------------------------------------------------------"
echo
#
apt-get update && apt-get upgrade -y
#
echo "\033[0;32m"    |     |         |          |                     |
echo "\033[0;32m"     _ \  |   _` |  | /   -_)  | /   _` |    \    _` |   -_)   _| (_-<   _ \    \  "\033[0m"
echo "\033[0;32m"   _.__/ _| \__,_| _\_\ \___| _\_\ \__,_| _| _| \__,_| \___| _|   ___/ \___/ _| _| "\033[0m"
echo
echo
echo
echo "==============================================================="
echo
echo "All done!"
echo
echo "If you are confident that all went well, reboot this puppy and play."
echo
echo "If not, now is your (last?) chance to fix things."
echo
echo "==============================================================="
