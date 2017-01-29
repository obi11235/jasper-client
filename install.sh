#!/bin/bash

sudo apt-get update
sudo apt-get upgrade --yes
sudo apt-get install vim git-core python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio --yes

sudo pip install --upgrade setuptools
sudo pip install -r client/requirements.txt

chmod +x jasper.py

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

cd svox-1.0+git20110131
dpkg-buildpackage -rfakeroot -us -uc

echo 'Installing pocketsphinx'
sudo apt-get install pocketsphinx