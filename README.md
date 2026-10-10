# AX650一键展开工具

面向 AX650 板端（Ubuntu 22.04 aarch64）的一键环境准备脚本，依次完成：

1. 安装通用编译依赖：gcc / g++ / cmake / OpenCV / Eigen3 / Boost
2. 解包 `sources/axcl_inc.tar` 到 `/soc`，补齐 AXCL 头文件
3. 安装 **MindVision MVSDK（迈德威视）相机 SDK**（替代原来的海康 MVS）
4. 下载并编译安装 RMCVSerial 串口库
5. clone 并编译 [PHOENIX auto-aim](https://github.com/ShiSanLiuHuo/ax650_auto_aim)

## 相机 SDK：MindVision MVSDK

`sources/mindvision_arm64_v2.1.0.37.tar.gz` 是官方 Linux SDK `linuxSDK_V2.1.0.37` 的 arm64 子集，包含
`include/{CameraApi.h,CameraDefine.h,CameraStatus.h}`、`lib/arm64/libMVSDK.so` 和厂商的 udev 规则。
`AutoInstall.sh` 会执行：

| 步骤 | 落地位置 |
| --- | --- |
| 复制 udev 规则（USB 相机免 root 访问） | `/etc/udev/rules.d/{88,99}-mvusb.rules` |
| 复制头文件 | `/usr/include/mindvision/` |
| 复制 aarch64 动态库并刷新缓存 | `/usr/lib/aarch64-linux-gnu/libMVSDK.so` + `ldconfig` |
| 写入环境变量 | `~/.bashrc` 中的 `MINDVISION_PATH` |

安装后需要重新插拔相机或重启，udev 规则才生效。

auto-aim 侧对应的编译开关：

```bash
# MindVision（默认）
cmake -S . -B build -DINFERENCE_BACKEND=AXCL -DUSE_MINDVISION=ON
# 旧的 MVS 路径（需要环境里有 MVS_PATH，两个开关互斥）
cmake -S . -B build -DINFERENCE_BACKEND=AXCL -DUSE_HIKCAM=ON
```

## 可选：海康 MVS（USE_HIKCAM=ON）

`sources/MVS_aarch.deb` 保留作离线备用包，`AutoInstall.sh` 默认不再安装它。需要回到海康相机时手动执行：

```bash
dpkg -i sources/MVS_aarch.deb
echo 'export MVS_PATH=/opt/MVS/lib/aarch64/' >> ~/.bashrc
source ~/.bashrc
```

然后按上面的 `-DUSE_HIKCAM=ON` 重新配置并编译 auto-aim。

## 首次启动特别注意：
### 从命令行中启用网卡内核模块并加入开机自启：
```bash
insmod /lib/modules/5.15.73/rtl8xxxu.ko
echo "rtl8xxxu" > /etc/modules-load.d/rtl8xxxu.conf
depmod
```
### 手动连接到Battelfield (nmcli)
