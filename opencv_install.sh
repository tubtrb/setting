echo ""
echo "====================package download===================="
sudo apt update && sudo apt install -y cmake g++ wget unzip libgtk2.0-dev

echo ""
echo "====================download the opencv source===================="

mkdir opencv
cd opencv

wget -O opencv.zip https://github.com/opencv/opencv/archive/4.6.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.6.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

mkdir build
cd build

echo ""
echo "====================configure cmake without ffmpeg===================="
cmake \
-DOPENCV_GENERATE_PKGCONFIG=ON \
-D WITH_FFMPEG=OFF \
-D WITH_GTK=ON \
../opencv-4.6.0/

echo ""
echo "====================build the opencv source===================="
time make -j$(nproc)

echo ""
echo "====================make install===================="
sudo make install

echo ""
echo "====================linking opencv===================="
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

echo ""
echo "====================check opencv linking===================="
pkg-config --modversion opencv4
# pkg-config --list-all | grep opencv