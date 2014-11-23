#!/bin/bash
# -------------------------------------------------------------------------
# Script to add a user to Linux system
# -------------------------------------------------------------------------
# Copyright (c) 2007 nixCraft project <http://bash.cyberciti.biz/>
# This script is licensed under GNU GPL version 2.0 or above
# Comment/suggestion: <vivek at nixCraft DOT com>
# -------------------------------------------------------------------------
# See url for more info:
# http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
# -------------------------------------------------------------------------
#
#
# ================================================================== #
#          Define system specific details in this section            #
# ================================================================== #
#
USER=usernamehere
PUBLICKEY="ssh-rsa ... user@example.com"
# ================================================================== #
#                      End system specific details                   #
# ================================================================== #
#
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
# -------------------------------------------------------------------------
# End script to add a user to Linux system
# -------------------------------------------------------------------------
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
