# Volumio Docker on Wisnuc #
## 闻上安装volumio ##
### special thanks to 天津-毅颗流星 ，没有他就没有这篇教程 ###

================

### 配置声卡 ###

1.   apt-get install libasound2 alsa-utils alsa-oss
2.   插入usb声卡，**aplay -l**
    
     ``` 
     **** List of PLAYBACK Hardware Devices ****
     card 0: Device [USB PnP Sound Device], device 0: USB Audio [USB Audio]
     Subdevices: 0/1
     Subdevice #0: subdevice #0
     ```
3.  记录 **device 0**: USB Audio [USB Audio]，device的id，非常重要
4.  vi  /etc/asound.conf 


    ``` 
    defaults.pcm.card 0
    defaults.ctl.card 0
    ```
    
    
5.  vi /etc/modprobe.d/alsa-base.conf 

    ``` 
    options snd_usb_audio index=0 
    ```
6.  vi /etc/security/limits.conf  添加下述内容
   
    ```
    @audio - rtprio 99 
    @audio - memlock unlimited 
    @audio - nice -10
    ```    
    
  ### 安装docker ###
  #### 自行替换 host的网址，音乐文件夹目录，程序配置目录 ###

```
  docker run --restart=always -d --name volumio \
  -e HOST=http://192.168.1.10:3000 \
  -p 3000:3000 \
  -v /sharedfolders/musics/DATA:/var/lib/mpd/music/:ro \
  -v /sharedfolders/musics/volumio:/data \
  --device /dev/snd \
  jbonjean/volumio
```
       
