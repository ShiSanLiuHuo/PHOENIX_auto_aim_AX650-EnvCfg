# Nvidia-NX Environment Auto Config
## This Project implies auto config shell to auto config Nvida-NX.
## List of sections and packages
* apt source:
  <br> This section will change the source of apt to ***TsingHua Mirror***
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
