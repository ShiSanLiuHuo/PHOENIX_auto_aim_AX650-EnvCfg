sudo jetson_clocks

#change apt source
echo 'Adding apt source, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
    echo 'apt source changing skipped'
else
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ./sources/sources.list /etc/apt/sources.list
    sudo apt install -y python3-pip
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    sudo apt-get update
    echo 'apt source change complete'
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
echo 'Installing Eigen3 and Serial. Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
    echo 'serial libs installation skipped'
else
    sudo apt-get install -y libeigen3-dev libboost-dev
    sudo cp ./sources/70-ttyths.rules /etc/udev/rules.d/70-ttyths.rules
    echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
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
    sudo rm -rf ceres-solver-2.0.0
    #To origin
    cd ..
fi
