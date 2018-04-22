#!/bin/bash
. ./config.sh

object_os=$( cat /etc/lsb-release  | grep -o $os_required )
if [[ $object_os==$os_required ]];then
	echo "os right!"
fi
##update && install 
if apt update  -qq  | grep -o 'E:';then
   echo "something wrong"
else
   echo "update successfully"
fi
if  apt install proftpd expect nfs-kernel-server  isc-dhcp-server bind9 smbclient -y -qq  | grep -o 'E:';then
   echo "something wrong"
	exit 1
else
   echo "install successfully"
fi

##replace config file

######设置FTP############
#判断匿名目录是否存在
if [ ! -d $Anonymous_File ];then
	mkdir $Anonymous_File
fi
#判断非匿名用户目录是否存在
if [ ! -d $Ftp_User_Home ];then
	mkdir $Ftp_User_Home
fi
#复制配置文件
if [ ! -f /etc/proftpd/proftpd.conf ]; then
	echo "something wrong with proftpd "
else 
# cp: error message format 
	cp /etc/proftpd/proftpd.conf  /etc/proftpd/proftpd.conf.bak
	if cp conf/proftpd.conf /etc/proftpd/proftpd.conf | grep -o 'cp:';then
		echo "something wrong with cp proftpd.conf"
	fi
fi
#添加非匿名用户
./expect_ftp_user.sh
##重启测试
echo "proftpd setting ok!!!!!!!!!!!"



########配置NFS##############
#判断可读可写目录是否存在
if [ ! -d $NFS_Share_Dir_R_W ];then
	mkdir $NFS_Share_Dir_R_W
fi
#判断只读目录是否存在
if [ ! -d $NFS_Share_Dir_R_O ];then
	mkdir $NFS_Share_Dir_R_O
fi
#复制配置文件
if [ ! -f /etc/exports ]; then
	echo "something wrong with nfs  "
else 
# cp: error message format 
	cp /etc/exports  /etc/exports.bak
	if cp conf/exports /etc/exports | grep -o 'cp:';then
		echo "something wrong with cp esports"
	fi
fi
echo "NFS setting ok!!!!!!!!!!!"


#######配置DHCP#####
#测试配置的网卡是否可用
cat interface >> /etc/network/interfaces
Status=$(ifup -a --no-act ; echo "status: $?" | grep -oP "status:.+")
if [[ $Status != "status: 0" ]];then
	echo "something wrong happened in interfaces setting "
else
#复制配置文件
if [ ! -f /etc/default/isc-dhcp-server ]; then
	echo "something wrong with dhcp "
else 
# cp: error message format 
	cp /etc/default/isc-dhcp-server  /etc/default/isc-dhcp-server.bak
	if cp conf/isc-dhcp-server /etc/default/isc-dhcp-server | grep -o 'cp:';then
		echo "something wrong with cp isc-dhcp-server"
	fi
fi

if [ ! -f /etc/dhcp/dhcpd.conf  ]; then
	echo "something wrong with dhcp  "
else 
# cp: error message format 
	cp  /etc/dhcp/dhcpd.conf  /etc/dhcp/dhcpd.conf.bak
	if cp conf/dhcpd.conf /etc/dhcp/dhcpd.conf | grep -o 'cp:';then
		echo "something wrong with cp dhcpd.conf"
	fi
fi
echo "DHCP setting  OK!!!"
fi



########配置DNS##########
#创建相应db文件 只需更改名字即可 

#复制文件
if [ ! -f /etc/bin/db.${Host_name} ];then
	cp conf/host_name.db /etc/bind/db.${Host_name}
else
	cp /etc/bind/db.${Host_name} /etc/bind/db.${Host_name}.bak
	cp conf/host_name.db /etc/bind/db.${Host_name}
fi


if [ ! -f /etc/bind/named.conf.local  ]; then
	echo "something wrong with dns_server "
else 
# cp: error message format 
	cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
	if cp conf/named.conf.local  /etc/bind/named.conf.local  | grep -o 'cp:';then
		echo "something wrong with cp named.conf.conf"
	fi
fi

echo "DNS  setting ok!!!"

######重启服务######
systemctl restart proftpd isc-dhcp-server  nfs-kernel-server bind9





