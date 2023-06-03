# package download

apt install -y bc
apt install -y bison
apt install -y flex
apt install -y libssl-dev

# chapter 2

mkdir ~/rpi_kernel_src
cd ~/rpi_kernel_src

git clone --branch rpi-4.19.y --depth=1 https://github.com/raspberrypi/linux