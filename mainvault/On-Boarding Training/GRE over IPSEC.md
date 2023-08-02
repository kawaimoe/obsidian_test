GRE:y

- doesnt have security
- sends all types of packets

IPsec:

- super secure
- provides:
    - Confidentiality: Encryption
    - Integrity:Hashing
    - Authentication: PSKs or Digital Signatures
    - Anti-relay: Serial numbers on packets
- CONS: only encapsulate unicast packets
- Two modes:
    - transport mode: Uses packets original header
    - tunnel mode: encapsulate entire packet
- Setup Steps:
    1.  Establish an Internet Key Exchange (IKE) Phase 1 Tunnel
    2.  Establish IKE Phase 2 tunnel

Best solution is to use GRE packets over IPsec.

Once packets are inside of GRE they are now UNICAST packets, from here they can be sent over IPsec

![Screenshot 2023-02-28 at 11.28.12.png](../_resources/Screenshot%202023-02-28%20at%2011.28.12.png)

```cisco
Config: R1

int tunnel 1

ip address 192.168.0.1 255.255.255.252

tunnel source gig 0/1

tunnel destination 198.51.100.2

end

#configure ipsec#

conf t

crytpo isakamp policy 10

encryption aes 

authentication pre-share 

group 2 <--- pick a shared group

exit

crypto isakamp key {users key} address 0.0.0.0 0.0.0.0 <---- (anybody)

crypto ipsec transform-set KWTRAIN esp-aes esp-sha-hmac

mode transport

exit
#tell router that GRE traffic should be encrypted#

ip access-list extended GRE-IN-IPSEC

permit gre any any

exit

#create crypto map that ties things together#

crypto map VPN 10 ipsec-isakamp

#map address inside extended access control list and put in tunnel#

match address GRE-IN-IPSEC

set transform-set KWTRAIN

set peer 192.51.100.2

#apply crypto map to g0/1#

crypto map VPN
exit
```

```cisco
Config: R4

conf t

int tunnel 1

tunnel source gig 0/1

ip address 192.168.0.2 255.255.255.252

tunnel destination 192.0.2.1

end
```

test commands:

>crypto isakamp sa

>show crypto ipsec a