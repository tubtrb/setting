# Ubuntu Version 20.04
# ROS Version: noetic
# Velodyne version: vlp16
# http://wiki.ros.org/ROS/Tutorials

#--------------------------Ros install start-----------------
# http://wiki.ros.org/noetic/Installation/Ubuntu
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt install -y curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update -y

sudo apt install -y ros-noetic-desktop

source /opt/ros/noetic/setup.bash

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

sudo apt install -y python3-rosdep

sudo rosdep init
rosdep update

#---------------------Ros Workspace(catkin)-------------------
# http://wiki.ros.org/catkin/Tutorials/create_a_workspace
# source /opt/ros/noetic/setup.sh

mkdir -p ~/catkin_ws/src 
cd ~/catkin_ws
catkin_make
source devel/setup.bash

#---------------------Ros make package-------------------
cd ~/catkin_ws/src
catkin_create_pkg ettifos_lidar_demo std_msgs roscpp message_generation sensor_msgs roslib pcl_conversions pcl_ros

cd ~/catkin_ws
catkin_make
source devel/setup.bash

#---------------------Ros VelodyneTutorial-------------------
# http://wiki.ros.org/velodyne/Tutorials/Getting%20Started%20with%20the%20Velodyne%20VLP16

#sudo apt-get install ros-VERSION-velodyne
sudo apt-get install -y ros-noetic-velodyne


cd ~/catkin_ws/src/ && git clone https://github.com/ros-drivers/velodyne.git

cd ~/catkin_ws

rosdep install --from-paths src --ignore-src --rosdistro YOURDISTRO -y

cd ~/catkin_ws/ && catkin_make

