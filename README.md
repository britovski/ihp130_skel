# ihp130_skel

This repository contains scripts for setting up EDA open source tools and the open source IHP 130 nm PDK.

## Guiding instructions

### Pre-requisites
First of all, you need to have linux (even if you decide to use WSL)! The scripts were implemented and tested for CentOS 7 distribution (7.9), which is a commonly used distribution for commercial EDA tools (OpenSUSE port is coming...). Ubuntu is more used from open source community and the scripts can be adapted to use with it.

So you need to have an installation of CentOS 7 on your computer. If you don't have yet, you need to choose between 3 options:
- single linux installation;
- dual-boot installation (if you really want to maintain windowns, or maybe macOSX);
- linux on a virtual machine (VM) running on windows.

Of course, the worst option is to run on a virtual machine because virtualization can slower the processing, but works, and I tested the scripts in both "dedicated" linux and also using Oracle VirtualBox VM's.

If you want to know how to install CentOS 7 see the following instuctions: https://linoxide.com/how-tos/centos-7-step-by-step-screenshots/

At least 20 Gb space is required but more is recommended.

### Minimal Skel
Once you have a fresh CentOS 7 Linux installed, you can setup an skel to use IHP130 open-PDK, following below steps:

Step 1. Download (or clone this repository) and change scripts file permissions.

        chmod 777 *.sh

Step 2. Run the 'minimal_opentools.sh' as root and them run the 'ihp130_workarea.sh' script as user.

        su
        ./minimal_opentools.sh
        exit
        ./minimal_sky130_skel.sh

Since the EOL of Centos 7, it is possible that you have problems with yum repository when execute the first script from step 2. So, if it is the case, just copy the CentOS-Base.repo on the /etc/yum.repos.d folder (we provided this file on extras folder in this repository) before execute the scripts.

        sudo cp CentOS-Base.repo /etc/yum.repos.d

This installation support basic analog IC design flow with following open source EDA tools:
- ngspice (version 43) with OSDI support;
- xschem schematic capture (version 3.4.5);
- gaw3 waveform viewer;
- klayout (version 0.29.0).

In order to use the tools with the open-PDK just go to the path of the desired tool on libs.tech.
