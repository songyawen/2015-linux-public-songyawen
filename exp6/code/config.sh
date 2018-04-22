#!/bin/bash
# 获取用户相关配置
# 可以写脚本用户输入 还可以减小风险
Username_Ssh=sonya
Hostip_Ssh=192.168.26.104
Password_Gn=toor
Root_Password=toor
os_required=16.04.4
Password_Ftp=ftp
Anonymous_File=/home/ftp
White_list_Ip=192.168.26.103
Ftp_User_Name=ftp_user1
Ftp_Group_Name=ftp_user1
Ftp_User_Home=/home/ftp_user1
##创建文件夹
NFS_Share_Dir_R_W=/usr/nfs/common
NFS_Share_Dir_R_O=/usr/nfs/only_read
## 
DHCP_Static_Inet_Name=enp0s9
DHCP_Static_IP_address=10.5.5.3
DHCP_Static_IP_netmask=255.255.255.0
DHCP_Static_Inet_gateway=10.5.5.3
DHCP_Subnet=10.5.5.0
DHCP_netmask=255.255.255.224
DHCP_Range_start=10.5.5.26
DHCP_Range_end=10.5.5.30
DHCP_domain_name_servers=t1.sonya.dhcp
DHCP_domain_name=t1.sonya.dhcp
DHCP_routers=10.5.5.1
DHCP_broadcast_address=10.5.5.31
Domain_Name=cuc.edu.cn
Host_name=wp.cuc.edu.cn.
Host_ip=10.5.5.28




