#!/bin/bash
# -------------------------------------------------------------------------
# Script to add a user to docker group
# -------------------------------------------------------------------------
#
# Define system specific details in this section

USER=usernamehere

# End system specific details
#
# -------------------------------------------------------------------------

echo "------------------> Adding the docker group"
sudo groupadd docker

echo "------------------> Adding $USER to the docker group"
sudo gpasswd -a $USER docker

echo "------------------> Restarting the docker daemon"
sudo service docker restart

echo ""
echo ""
echo "  $USER added sir!"
echo ""
echo "  Logout -> login and everything should be golden."
echo ""
echo ""
echo "                           :D"
echo ""
echo ""
