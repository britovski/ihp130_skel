#!\bin\bash

echo "Open Source Silicon tools installation for IHP130 PDK will begin..."

#echo "You will need root permissions to perform tools installation..."


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Setting up directories..."

cd /
mkdir edatools 
cd edatools
#mkdir tools
#cd tools
mkdir opentools
cd opentools

echo "Solving dependencies..."
yum update -y
yum upgrade -y
yum install gcc gcc-c++ autoconf automake patch patchutils indent libtool python3 cmake git -y
yum install mesa-libGL mesa-libGLU mesa-libGLU-devel libXp libXp-devel libXmu-devel tcl tk tcl-devel tk-devel cairo cairo-devel -y
yum install graphviz libXaw-devel readline-devel flex bison -y
yum install openmpi openmpi-devel openmpi3 openmpi3-devel -y #use if you want multi-core support
yum install qt-devel ruby ruby-devel python3-devel qt qt-x11 gtk3-devel -y

#git2
yum install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm -y
yum install git -y
###

yum install libgit2-devel -y

yum install xterm libjpeg-devel -y

echo "Downloading tools..."

wget -O ngspice-43.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/43/ngspice-43.tar.gz/download #https://sourceforge.net/projects/ngspice/files/ng-spice-rework/old-releases/33/ngspice-33.tar.gz/download
#wget -O adms-2.3.6.tar.gz https://sourceforge.net/projects/mot-adms/files/adms-source/2.3/adms-2.3.6.tar.gz/download

#wget http://opencircuitdesign.com/magic/archive/magic-8.3.494.tgz
#http://opencircuitdesign.com/magic/archive/magic-8.3.78.tgz

#wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.281.tgz
#http://opencircuitdesign.com/netgen/archive/netgen-1.5.155.tgz

wget https://www.klayout.org/downloads/CentOS_7/klayout-0.29.0-0.x86_64.rpm

wget -O xschem-3.4.5.tar.gz https://github.com/StefanSchippers/xschem/archive/refs/tags/3.4.5.tar.gz

wget http://download.tuxfamily.org/gaw/download/gaw3-20220315.tar.gz

wget https://datashare.tu-dresden.de/s/deELsiBGyitSS3o/download/openvaf_devel-x86_64-unknown-linux-gnu.tar.gz

#wget https://github.com/ra3xdh/qucs_s/releases/download/24.3.2/qucs-s-24.3.2.tar.gz

#wget -O openems-v0.0.36.tar.gz https://github.com/thliebig/openEMS-Project/archive/refs/tags/v0.0.36.tar.gz


echo "Installing tools..."

echo "Installing NGSpice with OSDI/OpenVAF and XSPICE support..."

tar zxvpf openvaf_devel-x86_64-unknown-linux-gnu.tar.gz
mv openvaf /usr/local/bin
rm -f openvaf_devel-x86_64-unknown-linux-gnu.tar.gz

tar zxvpf ngspice-43.tar.gz
cd ngspice-43
./configure --with-x --enable-xspice --enable-cider --enable-openmp --with-readline=yes --enable-predictor --enable-osdi
make -j$(nproc)
make install
if [ $? -ne 0 ]; then
    echo "Failed to install NGSpice."
    exit 1
fi
cd ..
rm -f ngspice-43.tar.gz

#echo "Installing Magic Layout..."
#tar zxvpf magic-8.3.78.tgz
#cd magic-8.3.78
#./configure
#make
#make install

#cd ..

#echo "Installing Netgen..."
#tar zxvpf netgen-1.5.155.tgz
#cd netgen-1.5.155
#./configure
#make
#make install

echo "Installing XSchem..."
tar zxvpf xschem-3.4.5.tar.gz
cd xschem-3.4.5
./configure
make
make install
if [ $? -ne 0 ]; then
    echo "Failed to install XSchem."
    exit 1
fi
cd ..
rm -f xschem-3.4.5.tar.gz

echo "Installing gaw..."
tar zxvpf gaw3-20220315.tar.gz
cd gaw3-20220315
./configure
make
make install
if [ $? -ne 0 ]; then
    echo "Failed to install GAW."
    exit 1
fi
cd ..
rm -f gaw3-20220315.tar.gz

echo "Installing KLayout..."
yum localinstall klayout-0.29.0-0.x86_64.rpm -y
if [ $? -ne 0 ]; then
    echo "Failed to install KLayout."
    exit 1
fi
rm -f klayout-0.29.0-0.x86_64.rpm

echo "Minimal EDA open source tools installation done!"
echo "Back to user and run the 'minimal_sky130_skel.sh' script"
