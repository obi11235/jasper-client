#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade --yes
sudo apt-get install vim git-core python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio --yes

sudo pip install --upgrade setuptools
sudo pip install -r client/requirements.txt

chmod +x jasper.py
exit


sudo apt-get install fakeroot debhelper automake autoconf libtool help2man libpopt-dev hardening-wrapper


echo 'Installing pico tts'
cd ..

mkdir pico_build
cd pico_build
sudo apt-get source libttspico-utils

cd svox-1.0+git20110131
dpkg-buildpackage -rfakeroot -us -uc

cd ..
sudo dpkg -i libttspico-data_1.0+git20110131-2_all.deb
sudo dpkg -i libttspico0_1.0+git20110131-2_armhf.deb
sudo dpkg -i libttspico-utils_1.0+git20110131-2_armhf.deb


cd ..
echo 'Installing pocketsphinx'
sudo apt-get install pocketsphinx

sudo apt-get install subversion autoconf libtool automake gfortran g++ --yes

svn co https://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk/
cd cmuclmtk/
./autogen.sh && make && sudo make install
cd ..

sudo su -c "echo 'deb http://ftp.debian.org/debian experimental main contrib non-free' > /etc/apt/sources.list.d/experimental.list"
sudo apt-get update
sudo apt-get -t experimental install phonetisaurus m2m-aligner mitlm libfst-tools

wget https://www.dropbox.com/s/kfht75czdwucni1/g014b2b.tgz
tar -xvf g014b2b.tgz
cd g014b2b/
./compile-fst.sh
cd ..
mv ~/g014b2b ~/phonetisaurus
