sudo apt install cifs-utils

sudo mkdir /media/share

sudo nano /root/.smbcredentials

Set the samba username and password to the above file.
username=smb_username
password=smb_password

sudo chmod 400 /root/.smbcredentials

sudo mount -t cifs -o rw,vers=3.0,credentials=/root/.smbcredentials [//192.168.1.14/backups](//192.168.1.14/backups) /media/share

sudo nano /etc/fstab

Add the line at end of the file as follows. Change values as per yours.
[//192.168.1.14/backups](//192.168.1.14/backups) /media/share cifs vers=3.0,credentials=/root/.smbcredentials