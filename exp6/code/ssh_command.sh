#!/bin/bash
. ./config.sh
#普通用户登录 更改设置允许root登录
bash config_replace_string.sh
echo "replace  ok !!"
object_os=$( cat /etc/lsb-release  | grep -o $os_required )
if [[ $object_os==$os_required ]];then
        echo "os right!"
fi
if  apt install sshpass -y -qq  | grep -o 'E:';then
   echo "something wrong"
        exit 1
else
   echo "install successfully"
fi


sshpass -p $Password_Gn scp -r $PWD/root_ssh $Username_Ssh@$Hostip_Ssh:/tmp/  
sshpass -p $Password_Gn ssh $Username_Ssh@$Hostip_Ssh bash /tmp/root_ssh/run.sh &>/dev/null 

if [ ! -f /root/.ssh/id_rsa.pub ]; then
    ssh-keygen ## todo : expect
fi

##without password login setting
sudo sshpass -p $Password_Gn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$Hostip_Ssh 
echo "root_login_ok"
##install 
#复制文件
sshpass  scp -r $PWD/ root@$Hostip_Ssh:$Tmp_Dir
sudo ssh root@$Hostip_Ssh cd /tmp/install && sudo bash install.sh


