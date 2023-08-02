curl -s https://install.zerotier.com | sudo bash

systemctl enable zero-one && zero-tier join 17d709436c52d6ab

Ip forwarding:

sudo iptables -t nat -A POSTROUTING -o  eth0 -j MASQUERADEsudo iptables -A FORWARD -i eth0 -o ztks5vxfoh -m state --state RELATED,ESTABLISHED -j ACCEPTsudo iptables -A FORWARD -i ztks5vxfoh -o eth0 -j ACCEPT