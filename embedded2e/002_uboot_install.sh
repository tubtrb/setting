#! /bin/bash

# ref: https://u-boot.readthedocs.io/en/latest/

# git fork from the master
# git clone git@github.com:u-boot/u-boot.git
git clone git@github.com:tubtrb/u-boot.git
cd u-boot

make CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- am335x_boneblack_defconfig
make CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- ARCH=arm CFLAGS="-march=armv7 -mtune=cortex-a8"
