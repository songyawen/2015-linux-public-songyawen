#!/usr/bin/expect
set password_ftp {{ Password_Ftp }}
log_user 0

spawn ftpasswd --passwd --file=/etc/proftpd/ftpd.passwd --name={{ Ftp_User_Name }}  --uid=0 --home={{ Ftp_User_Home }}  --shell=/sbin/nologin
expect "Password: "
send  "$password_ftp\n"
expect  "password: "
send "$password_ftp\n"
#ftpasswd --passwd $password --file=/etc/proftpd/ftpd.passwd --name=ftp_user1 --uid=0 --home=/home/ftp_user1 --shell=/sbin/nologin
spawn ftpasswd --group --file=/etc/proftpd/ftpd.group --name={{ Ftp_Group_Name }} --gid=0
spawn ftpasswd --group --name={{ Ftp_Group_Name }}  --gid=99 --member={{ Ftp_User_Name }}
spawn openssl req -new -x509 -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem -keyout /etc/proftpd/ssl/proftpd.key.pem

