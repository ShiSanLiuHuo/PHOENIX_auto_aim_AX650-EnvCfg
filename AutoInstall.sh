apt update
apt install -y gcc g++ cmake libboost-dev libopencv-dev libeigen3-dev libusb-1.0-0
tar -xvf sources/axcl_inc.tar -C /soc

#install MindVision MVSDK (replaces the Hikvision MVS runtime)
echo 'Installing MindVision MVSDK, Enter s to skip, Enter any other key to continue'
read skip
if [ "${skip}" = 's' ]; then
    echo 'MindVision MVSDK installation skipped'
else
    MV_TARBALL=$(ls sources/mindvision_arm64_*.tar.gz 2>/dev/null | head -n 1)
    if [ -z "${MV_TARBALL}" ]; then
        echo 'sources/mindvision_arm64_*.tar.gz not found, MindVision MVSDK installation skipped'
    else
        rm -rf sources/mindvision
        tar -xzf "${MV_TARBALL}" -C sources

        # udev rules: allow USB camera access without root
        mkdir -p /etc/udev/rules.d
        cp sources/mindvision/*-mvusb.rules /etc/udev/rules.d/
        getent group mvusb_dev >/dev/null || groupadd -r mvusb_dev
        udevadm control --reload-rules || true
        udevadm trigger || true

        # headers
        mkdir -p /usr/include/mindvision
        cp sources/mindvision/include/*.h /usr/include/mindvision/

        # shared library for aarch64
        MV_LIB_DIR=/usr/lib/aarch64-linux-gnu
        [ -d "${MV_LIB_DIR}" ] || MV_LIB_DIR=/usr/lib
        mkdir -p "${MV_LIB_DIR}"
        cp sources/mindvision/lib/arm64/libMVSDK.so "${MV_LIB_DIR}/"
        ldconfig

        echo "export MINDVISION_PATH=${MV_LIB_DIR}" >> ~/.bashrc
        source ~/.bashrc
        echo 'MindVision MVSDK installation complete'
        echo 'Replug the camera or reboot so the new udev rules take effect'
    fi
fi

#install libserial
echo 'Installing RMCVSerial. Enter s to skip, Enter any other key to continue'
read skip
if [ "${skip}" = 's' ]; then
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
if [ "${skip}" = 's' ]; then
    echo 'auto-aim installation skipped'
else
    cd ~
    git clone https://github.com/ShiSanLiuHuo/ax650_auto_aim.git auto-aim
    cd auto-aim
    mkdir build
    cd build
    cmake .. -DINFERENCE_BACKEND=AXCL -DUSE_MINDVISION=ON
    make -j4
    cd ..
    echo 'Please reboot and set configs to use auto-aim'
    echo 'Incase you want to use auto startup, refer to README.md in auto-aim.'
fi
