#!/bin/bash

echo "Setting up IHP PDK user workarea"

#if [[ $EUID -ne 1000 ]]; then
#   echo "This script must be run as user"
#   exit 1
#fi

cd ~/

git clone -b dev --recursive https://github.com/IHP-GmbH/IHP-Open-PDK.git

echo "export PDK_ROOT=\$HOME/IHP-Open-PDK" >> ~/.bashrc
echo "export PDK=ihp-sg13g2" >> ~/.bashrc
echo "export KLAYOUT_PATH=\"\$HOME/.klayout:\$PDK_ROOT/\$PDK/libs.tech/klayout\"" >> ~/.bashrc
echo "export KLAYOUT_HOME=\$HOME/.klayout" >> ~/.bashrc
source ~/.bashrc

pip3.11 install psutil
pip3.11 install docopt
pip3.11 install klayout

#export PDK_ROOT=~/IHP-Open-PDK
#export PDK=$PDK_ROOT/ihp-sg13g2

cd $PDK_ROOT/$PDK/libs.tech/xschem
python3.11 install.py

cd $PDK_ROOT/$PDK/libs.tech/qucs
python3.11 install.py

cd ~/

echo "IHP PDK user workarea setup done!"
