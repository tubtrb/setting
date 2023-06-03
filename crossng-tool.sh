#! /bin/bash

echo "=======================pkg install======================="
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y automake bison chrpath flex g++ git  \
gawk libexpat1-dev libncurses5-dev libsdl1.2-dev libtool \
python2.7-dev texinfo help2man


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
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng
git checkout crosstool-ng-1.22.0

echo "=======================start bootstrap======================="
./bootstrap &&
./configure --enable-local --with-bash=/usr/bin/bash --with-libtool=/usr/bin/libtool &&
make distclean
make
make install

./ct-ng
./ct-ng list-samples
./ct-ng show-arm-cortex_a8-linux-gnueabi
./ct-ng arm-cortex_a8-linux-gnueabi
./ct-ng menuconfig
./ct-ng build
