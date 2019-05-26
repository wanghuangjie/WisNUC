# WisNUC 闻上云管家ws215i 

### [OMV安装](https://openmediavault.readthedocs.io/en/latest/installation/on_debian.html)

### [volumio安装](https://github.com/wanghuangjie/WisNUC/blob/master/howtodockervolumio.md)

### [按钮监测_PWR_USBCOPY_RESET](https://raw.githubusercontent.com/wanghuangjie/WisNUC/master/buttonlistener.sh) 
# 其他：

### 风扇控制 
并不是很好的控制方案，每分钟根据cpu温度调整一次转速。led灯：高负载 快闪 中负载 慢闪  低负载 常闭

su 切换成root用户，默认密码yutech

apt-get install lm-sensors

mkdir /apps && cd /apps

wget https://raw.githubusercontent.com/wanghuangjie/WisNUC/master/fancontrol.sh

chmod a+x fancontrol.sh

测试脚本是否有效，执行后指示灯应熄灭，转速明显下降  ```./fancontrol.sh ```

查看当前转速  ```cat  /proc/FAN_io```

修改定时计划 ```crontab -e ``` 

```
#*/2 * * * * /usr/bin/sudo sh /unas/apps/errormessage/includes/check_error_db.sh 注释这两项可以开启硬盘休眠
#*/3 * * * * /usr/bin/sudo sh /unas/sbin/healthcheck.sh 注释这两项可以开启硬盘休眠
* * * * * /usr/bin/sudo sh /apps/fancontrol.sh
```



# 硬件:
![拆机](https://am.zdmimg.com/201604/05/5703a8469d1e6.jpg_e600.jpg)
* CPU: Intel ATOM CE5315 X86
* RAM: 2G - SAMSUNG 512M*4
* DISK: 4G - SANDISK SD1N7DP2-40
* IO: 
  * USB3.0*2 
  * HDMI
  * RJ45千兆网口
