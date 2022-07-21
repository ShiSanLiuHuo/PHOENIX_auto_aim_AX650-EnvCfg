# Nvidia-NX Environment Auto Config
## This Project implies auto config shell to auto config Nvida-NX.
## Pre-Config Operations
Download and install BalenaEther form https://www.balena.io/etcher/ or http://cloud.rmshtech.tk/share/JjL4JT-B

Download JetPack 4.6 Image from nvidia or http://cloud.rmshtech.tk/share/xBxSG_18

Flash the Image into TF Card.

## List of sections and packages
* apt source:
  <br> This section will change the source of apt to ***TsingHua Mirror***
* pip3
* jtop
* gcc/g++ 8 & 9:
  <br> This section will install gcc/g++ 8 & 9 from apt source. User may have to press ***ENTER*** to allow the shell to add *ppa:ubuntu-toolchain-r/test* into apt repository.
* MVS ( ***Third Party*** )
* libserial (from our ***GitLab*** )
* CMake-3.22.1 (from ***GitHub*** )
* OpenCV Relaies (from ***Apt*** )
## Instructions
* To run the project, run
```
git pull http://gitlab.rmshtech.tk/computer-vision/nvidianx-environment-config.git
cd nvidianx-environment-config
sudo bash ./AuutoInstall.sh
```
* In each section, before installing, you were required to enter a character and then press ***ENTER*** to decide whether you want to perform this part of installation. To skip certain part of installation, enter '***s***' and press ***ENTER***, otherwise, press ***any*** key and then press ***ENTER***.
## Extra Information for OpenCV Installation
### INSTALLATION OF OPENCV IS NOT NECESSARY FOR BASIC USAGE
### OPENCV 4.1.1 WITHOUT CUDA SUPPORT IS INSTALLED WITH JETPACK 4.6
### 安装 OpenCV 不是必选项
### 不带CUDA支持的 OpenCV 4.1.1 已随 JETPACK 4.6 安装
### Preparation
To install OpenCV, you are supposed to install relaying libraries. If you have successfully run the ***AutoInstall.sh***, you have already prepared.
### Get valid source code
Use git clone or wget to get OpenCV source code and OpenCV-Contrib source code.
In the following example, we will download source code from opencv github repositor.
```
wget https://hub.fastgit.org/opencv/opencv/archive/refs/tags/4.1.1.tar.gz
wget https://hub.fastgit.org/opencv/opencv_contrib/archive/refs/tags/4.1.1.tar.gz
```
use ***tar -xzf*** to unzip the file into proper position. Make new sub-directory 'build' and perform 
```
ccmake ..
```
Adjust settings and generate **Makefile**
```
make
sudo make install
```
