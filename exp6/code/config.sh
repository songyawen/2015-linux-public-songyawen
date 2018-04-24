#!/bin/bash
# 获取用户相关配置
# 可以写脚本用户输入 还可以减小风险

## 复制到目标被配置机器的临时目录
Tmp_Dir=/tmp/install


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
Domain_Name=cuc.edu.cn
Host_name=wp.cuc.edu.cn.
Host_ip=10.5.5.28




