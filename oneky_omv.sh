#!/bin/bash
OS=`tail -n 1 /etc/lsb-release | awk -F' ' 'NR==1{print $2}'`
kernel=`uname -r`
user=`whoami`
aptfast="/usr/local/sbin/apt-fast"
#if [ "$OS" != "16.04.6" ] || [ "$kernel" != "4.4.0-131-generic" ];then
if [ "$OS" != "16.04.3" ] || [ "$kernel" != "4.3.3.001+" ];then
    echo "您的系统不是官方原装ubuntu16.04系统, 无法安装，请更新到最新的官方系统之后再次运行本脚本。"
    echo "更新到最新的官方系统的方法如下："
    echo "下载群附件《WISNUC系统镜像（请解压后烧录安装）》并写入U盘。"
    echo "然后将U盘插入Wisnuc，启动之后自动升级系统，详情请参考群文件《WISNUC系统20170930版本安装说明》。"
    exit
fi
if [ "$user" != "root" ];then
    echo "您不是root用户，无法安装，即将退出。"
    echo "请在本脚本退出后执行命令sudo su之后再次运行本脚本。"
    exit
fi

echo
echo "即将安装apt-fast以加快之后的安装速度。"
apt install -y curl
/bin/bash -c "$(curl -sL https://git.io/vokNn)"

echo
echo "下面开始设置root用户的密码，请输入您想要设置的密码后请回车，系统会提示您再次输入密码以确认。"
passwd root

echo
echo "接下来开始新建openmediavault.list，并添加omv的源。此操作可能需要花十分钟时间，请耐心等待。"
rm -f /etc/apt/sources.list.d/openmediavault.list
echo 'deb https://packages.openmediavault.org/public arrakis main' > /etc/apt/sources.list.d/openmediavault.list
#echo 'deb https://downloads.sourceforge.net/project/openmediavault/packages arrakis main' > /etc/apt/sources.list.d/openmediavault.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7E7A6C592EF35D13
apt -y install apt-transport-https
apt update

echo
echo "下面开始下载并安装omv必需的btrfs-tools和btrfs-progs。"
wget http://ftp.br.debian.org/debian/pool/main/b/btrfs-progs/btrfs-tools_4.7.3-1_amd64.deb && dpkg -i btrfs-tools_4.7.3-1_amd64.deb
wget http://ftp.br.debian.org/debian/pool/main/b/btrfs-progs/btrfs-progs_4.7.3-1_amd64.deb && dpkg -i btrfs-progs_4.7.3-1_amd64.deb
dpkg -i btrfs-tools_4.7.3-1_amd64.deb

echo
echo "在正式开始安装omv之前，您是否希望禁用Wisnuc自带的服务？如果是，请输入y ；如果否，请输入n"
while [ true ]
  do
     read x
     case "$x" in
       y | yes )
        systemctl stop wetty.service wisnuc-bootstrap.service wisnuc-firstboot.service wisnuc-bootstrap-update.timer
        systemctl disable wetty.service wisnuc-bootstrap.service wisnuc-firstboot.service wisnuc-bootstrap-update.timer
        echo "Wisnuc自带的服务已经被成功地禁用了。"
        break
        ;;
       n | no )
        break
        ;;
       * )
        echo "输入无效，请输入y或者n!"
     esac
done

echo
echo "接下来正式开始下载并安装omv。此操作可能需要半小时，请耐心等待。"
apt remove openmediavault
if [ ! -f "$aptfast" ]; then
    apt-get -y --option Dpkg::Options::="--force-confdef" --option DPkg::Options::="--force-confold" install openmediavault
else
    apt-fast -y --option Dpkg::Options::="--force-confdef" --option DPkg::Options::="--force-confold" install openmediavault
fi
omv-initsystem

echo
echo "安装完成! 浏览器打开http://ip 去试试您的OMV!"
echo "登陆用户名是admin， 密码是openmediavault"
exit
