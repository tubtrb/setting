#! /bin/bash

echo "=======================pkg install======================="
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y automake bison chrpath flex g++ git  \
gawk libexpat1-dev libncurses5-dev libsdl1.2-dev libtool \
python2.7-dev texinfo help2man libtool-bin


# gperf specific version (3.0.4)
wget http://ftp.gnu.org/gnu/gperf/gperf-3.0.4.tar.gz
tar -xzf gperf-3.0.4.tar.gz -C .
cd gperf-3.0.4
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4 && make
make install &&
install -m644 -v doc/gperf.{dvi,ps,pdf} \
                 /usr/share/doc/gperf-3.0.4 &&

pushd /usr/share/info &&
  rm -v dir &&
  for FILENAME in *; do
    install-info $FILENAME dir 2>/dev/null
  done &&
popd

# after install the package 
sync



echo "=======================git download======================="
wget https://github.com/crosstool-ng/crosstool-ng/releases/download/crosstool-ng-1.25.0/crosstool-ng-1.25.0.tar.xz

cd crosstool-ng



echo "=======================start bootstrap======================="
./bootstrap &&
./configure --enable-local
make distclean
make
make install



echo ""=======================beagle bone black compiler"======================="
./ct-ng
./ct-ng list-samples
./ct-ng show-arm-cortex_a8-linux-gnueabi
./ct-ng arm-cortex_a8-linux-gnueabi
./ct-ng menuconfig
./ct-ng build

echo ""=======================qemu cross compiler"======================="
./ct-ng distclean
./ct-ng arm-unknown-linux-gnueabi
./ct-ng build


sudo apt update -y && sudo apt upgrade -y

sudo apt install -y gcc-7 gcc-8 g++-7 g++-8

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9

sudo update-alternatives --config gcc
sudo update-alternatives --config g++
