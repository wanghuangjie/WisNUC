#!/bin/bash
cpu_temp=$(sensors -u|sed -n '/Core 0/ {n;p}'|awk {'print $2'}|sed 's/.000//') #获取cpu当前温度

low=40 #低负载
mid=50 #中负载
high=60  #高负载
#--------------end of configure file--------------

change_fan_level() {
    echo $1 > /proc/FAN_io
}

if [ $cpu_temp -gt $high ]
then
change_fan_level 100 #全速
elif [ $cpu_temp -gt $mid ] 
then
change_fan_level 40 #中速
elif [ $cpu_temp -gt $low ]
then
change_fan_level 25 #低速
else
change_fan_level 50 #获取不到cpu温度时恒定50
fi
