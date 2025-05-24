# AX650一键展开工具

## 首次启动特别注意：
### 从命令行中启用网卡内核模块并加入开机自启：
```bash
insmod /lib/modules/5.15.73/rtl8xxxu.ko
echo "rtl8xxxu" > /etc/modules-load.d/rtl8xxxu.conf
depmod
```
### 手动连接到Battelfield (nmcli)