sudo jetson_clocks

#change apt source
echo 'Adding apt source, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'apt source changing skipped'
else
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp ./sources/sources.list /etc/apt/sources.list
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
sudo apt-get update
echo 'apt source change complete'
fi

#install pip3
echo 'Installing pip3, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'pip3 installation skipped'
else
sudo apt-get install -y python3-pip
echo 'pip3 installation complete'
fi

#install jtop
echo 'Installing jtop, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'jtop installation skipped'
else
sudo -H pip3 install -U jetson-stats
echo 'jtop installation complete'
fi

#install gcc-8/gcc-9
echo 'Installing gcc/g++ 8 & 9, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'gcc/g++ 8 & 9 installation skipped'
else
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y gcc-8 g++-8
sudo apt-get install -y gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9
echo 'gcc/g++ 8 & 9 installation complete'
fi

#install MVS
echo 'Installing MVS, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'MVS installation skipped'
else
sudo dpkg -i ./sources/MVS_aarch.deb
echo 'export MVS_PATH=/opt/MVS/lib/aarch64/' >> ~/.bashrc
source ~/.bashrc
echo 'MVS installation complete'
fi

#install libserial
echo 'Installing serial libs, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'serial libs installation skipped'
else
sudo apt-get install -y catkin
git clone http://gitlab.rmshtech.tk/hegq/libserial.git
cd libserial
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local
make -j
sudo make install
cd ..
rm -rf libserial
sudo cp ./sources/70-ttyths.rules /etc/udev/rules.d/70-ttyths.rules
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
echo 'serial libs installation complete'
echo 'Please reboot and check status of ttyTHS1 after whole installation complete'
fi

#install cmake-3.22
echo 'Installing CMake-3.22, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'CMake-3.22 installation skipped'
else
cd sources
wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-linux-aarch64.tar.gz
tar -xzf cmake-3.22.1-linux-aarch64.tar.gz
sudo mv cmake-3.22.1-linux-aarch64 /opt/cmake-3.22
sudo ln -sf /opt/cmake-3.22/bin/* /usr/bin/
cd ..
echo 'CMake-3.22 installation complete'
fi

#install ceres
echo 'Installing ceres, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'ceres installation skipped'
else
cd sources
wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/2.0.0.tar.gz
tar -xzf 2.0.0.tar.gz
cd ceres-solver-2.0.0
mkdir build
cd build
cmake .. -DMINIGLOG=TRUE
make -j6
sudo make install
#To ceres
cd ..
cd ..
#To source
#To origin
cd ..
fi

#install opencv
echo 'Installing OpenCV, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
echo 'OpenCV installation skipped'
else
sudo apt-get install -y libgtk2.0-dev libgtk3.0-dev
sudo apt-get install -y libavcodec-dev libavformat-dev
sudo apt-get install -y libswscale-dev libv4l-dev libtff5-dev
sudo apt-get install -y libv4l-dev libxvidcore-dev libx264-dev
sudo apt-get install -y libatlas-base-dev gfortran libgtk2.0-dev 
sudo apt-get install -y libjpeg-dev libpng-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
echo 'OpenCV supporting libs installation complete'
echo 'Please manually install OPENCV 4.1.1'
fi
