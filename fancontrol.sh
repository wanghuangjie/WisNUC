#!/bin/bash

# By wanghuangjie
# v0.02
cpu_temp=$(sensors -u|sed -n '/Core 0/ {n;p}'|awk {'print $2'}|sed 's/.000//') #获取cpu当前温度

low=35 #低负载
mid=40 #中负载
high=60  #高负载
#--------------end of configure file--------------

change_fan_level() {
    echo $1 > /proc/FAN_io
}

if [ $cpu_temp -gt $high ]
then
change_fan_level 100 #全速
echo PWR_LED 3 > /proc/BOARD_io #快闪
elif [ $cpu_temp -gt $low ] 
then
change_fan_level 40 #中速
echo PWR_LED 2 > /proc/BOARD_io #慢闪
elif [ $cpu_temp -le $low ]
then
change_fan_level 25 #低速
echo PWR_LED 0 > /proc/BOARD_io #常闭
else
change_fan_level 50 #获取不到cpu温度时恒定50
echo PWR_LED 1 > /proc/BOARD_io  #常开
fi


