#!/bin/bash
. ./config.sh

sed -i "s#Tmp_Dir#${Tmp_Dir}#g"  ssh_root_withoutpwd.sh
sed -i "s/Password_Gn/${Password_Gn}/g"  root_ssh/script_exp.exp
sed -i "s/Root_Password/${Root_Password}/g"  root_ssh/script_exp.exp
sed -i "s/Password_Ftp/${Password_Ftp}/g"  expect_ftp_user.sh
sed -i "s#Anonymous_File#${Anonymous_File}#g" conf/proftpd.conf
sed -i "s/White_list_Ip/${White_list_Ip}/g" conf/proftpd.conf
sed -i "s/Ftp_User_Name/${Ftp_User_Name}/g" expect_ftp_user.sh
sed -i "s/Ftp_Group_Name/${Ftp_Group_Name}/g" expect_ftp_user.sh
sed -i "s#Ftp_User_Home#${Ftp_User_Home}#g" expect_ftp_user.sh
sed -i "s#NFS_Share_Dir_R_O#${NFS_Share_Dir_R_O}#g" conf/exports
sed -i "s#NFS_Share_Dir_R_W#${NFS_Share_Dir_R_W}#g" conf/exports
sed -i "s/Domain_Name/${Domain_Name}/g" conf/named.conf.local
sed -i "s/Host_name/${Host_name}/g" conf/host_name.db
sed -i "s/Host_ip/${Host_ip}/g" conf/host_name.db
