### Step to the left, (Initial build):
*Note1: change the VR hosted url*
*Note2: if the Linux machines arn't using a DNS server modify the /etc/hosts file to include the 'velociraptor' hostname and the FQDN name of the velociraptor server url specified in the client.config.yaml file*
```Bash
wget -O /tmp/velociraptor http://velociraptor:5003/linux/velociraptor_client_repacked 
&& vr_binary=/tmp/velociraptor 
&& wget -O /tmp/client.config.yaml http://velociraptor:5003/client.config.yaml
&& sudo chmod +x /tmp/velociraptor;/tmp/client.config.yaml
&& $vr_binary=/tmp/vwelociraptor
&& $config=/tmp/client.config.yaml
&& systemd-run -u velociraptor_tmp $vr_binary client --config $config 
&& systemctl status velociraptor_tmp.service
```
### Step to the right, (VR persistence): 
*Note: change the VR hosted url*
``` Bash
(crontab -l 2>/dev/null; echo "@reboot 
wget -O /tmp/velociraptor http://velociraptor:5003/linux/velociraptor_client_repacked && vr_binary=/tmp/velociraptor 
&& wget -O /tmp/client.config.yaml http://velociraptor:5003/client.config.yaml
&& chmod +x /tmp/velociraptor;/tmp/client.config.yaml
&& $vr_binary=/tmp/vwelociraptor
&& $config=/tmp/client.config.yaml
&& systemd-run -u velociraptor_tmp $vr_binary client --config $config 
") | sudo crontab -
``` 
### Crisscross!
*Note: change the VR hosted url*
```Bash
wget -O /tmp/velociraptor http://velociraptor:5003/linux/velociraptor_client_repacked && vr_binary=/tmp/velociraptor && wget -O /tmp/client.config.yaml http://velociraptor:5003/client.config.yaml&& chmod +x /tmp/velociraptor;/tmp/client.config.yaml&& $vr_binary=/tmp/vwelociraptor&& $config=/tmp/client.config.yaml&& systemd-run -u velociraptor_tmp $vr_binary client --config $config && systemctl status velociraptor_tmp.service && (crontab -l 2>/dev/null; echo "@reboot 
wget -O /tmp/velociraptor http://velociraptor:5003/linux/velociraptor_client_repacked && vr_binary=/tmp/velociraptor && wget -O /tmp/client.config.yaml http://velociraptor:5003/client.config.yaml&& chmod +x /tmp/velociraptor;/tmp/client.config.yaml&& $vr_binary=/tmp/vwelociraptor&& $config=/tmp/client.config.yaml&& systemd-run -u velociraptor_tmp $vr_binary client --config $config 
") | sudo crontab -
```