virtualises routers inside one router

![Screenshot 2023-02-27 at 14.48.30.png](../_resources/Screenshot%202023-02-27%20at%2014.48.30.png)

commands:

COMMON (config)#vrf definition TENANT-A

COMMON (config-vrf)#address-family ipv4

COMMON (config-vrf-af)#exit

COMMON (config-vrf)#exit

COMMON (config)#vrf definition TENANT-B

COMMON (config-vrf)#address-family ipv4

COMMON (config-vrf-af)#exitCOMMON (config-vrf)#exit

COMMON (config)#int gig 0/1

COMMON (config-if)#vrf for

COMMON (config-if)#vrf forwarding TENANT-A

COMMON (config-if)#ip address 192.0.2.1 255.255.255.0

COMMON (config-if)#no shut

COMMON(config-if)#int gig

COMMON(config-if)#int gig 0/2

COMMON (config-if)#vrf forwarding TENANT-A

COMMON (config-if)#ip address 10.1.1.1 255.255.255.0

COMMON (config-if)#no shut

COMMON (config-if)#int gig 0/3

COMMON (config-if)#vrf forwarding TENANT-B

COMMON (config-if)#ip address 10.1.1.1 255.255.255.0

COMMON (config-if)#no shut

COMMON(config-if)#int gig 0/4 

COMMON (config-if)#int gig 0/4

COMMON (config-if)#vrf forwarding TENANT-B

COMMON(config-if) #ip address 198.51.100.1 255.255.255.0

COMMON (config-if)#no shut

COMMON (config-if)#end

Test:

>show ip vrf

>show ip route vrf TENNANT-#