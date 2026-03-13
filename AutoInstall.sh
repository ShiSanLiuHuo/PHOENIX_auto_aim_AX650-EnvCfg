apt update
apt install -y gcc g++ cmake libboost-dev libopencv-dev libeigen3-dev
tar -xvf sources/axcl_inc.tar -C /soc

#install MVS
echo 'Installing MVS, Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
    echo 'MVS installation skipped'
else
    dpkg -i ./sources/MVS_aarch.deb
    echo 'export MVS_PATH=/opt/MVS/lib/aarch64/' >> ~/.bashrc
    source ~/.bashrc
    echo 'MVS installation complete'
fi

#install libserial
echo 'Installing RMCVSerial. Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
    echo 'serial libs installation skipped'
else
    cd sources
    wget https://gitlab.rmshtech.com/computer-vision/tools/rmcv_serial/-/archive/V1.1.1/rmcv_serial-V1.1.1.tar
    tar -xf rmcv_serial-V1.1.1.tar
    rm rmcv_serial-V1.1.1.tar
    cd rmcv_serial-V1.1.1
    mkdir build
    cd build
    cmake ..
    make -j
    sudo make install
    cd ../..
    rm -rf rmcv_serial-V1.1.1
    cd ..
    
    echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
    echo 'serial libs installation complete'
    echo 'Please reboot and check status of ttyTHS1 after whole installation complete'
fi

#install auto-aim
echo 'Installing autoaim. Enter s to skip, Enter any other key to continue'
read skip
if [ ${skip} == 's' ]; then
    echo 'auto-aim installation skipped'
else
    cd ~
    echo "deploying account username:cvdeployer password:robomaster"
    git clone http://gitlab.rmshtech.com/computer-vision/auto-aim
    cd auto-aim
    mkdir build
    cd build
    cmake .. -DINFERENCE_BACKEND=AXCL
    make -j4
    cd ..
    echo 'Please reboot and set configs to use auto-aim'
    echo 'Incase you want to use auto startup, refer to README.md in auto-aim.'
fi
