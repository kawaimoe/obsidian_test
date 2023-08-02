|     |     |     |     |
| --- | --- | --- | --- |
| Address Class | Value in First Octet | Classful Mask (Dotted Decimal) | Classful Mask (Prefix Notation) |
| A   | 1-126 | 255.0.0.0 | /8  |
| B   | 128-191 | 255.255.0.0 | /16 |
| C   | 192-223 | 255.255.255.0 | /24 |
| D (Multicast) | 224-239 | N/A | N/A |
| E   | 240-255 | N/A | N/A |

Private address classes

|     |     |     |
| --- | --- | --- |
| Address Classes | Address range | Default Subnet Mask |
| A   | 10.0.0.0 - 10.255.255.255 | 255.0.0.0 |
| B   | 172.16.0.0 - 172.31.255.255 | 255.255.0.0 |
| B (APIPA) | 169.254.0.0 - 169.254.255.255 | 255.255.0.0 |
| C   | 192.168.0.0 - 192.168.255.255 | 255.255.255.0 |

### Unicast:

One-to-one comms: sends to everyone that wants it, however sends it once at a time, doesn't scale well

### Broadcast:

Sends to everyone <ins>once</ins> wether they want it or not, relies on mac address

### Multicast:

Sends once to group of IP multicast group,

Binary convert table:

|     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| 1   | 1   | 1   | 0   | 0   | 0   | 0   | 0   |

255.255.255.224 subnet mask applied to a natural Class C mask is /27 and has 3 borrowed bits ( **111**00000 = 224 ) and the host bits = 5 (111**00000**)

To calculate the number of subnets is 2*(borrowed bits = 3) = 8

To calculate the number of assignable IP addresses in a subnet is 2*(number of host bits) - 2

|     |     |
| --- | --- |
| Number of host bits | Assignable hosts |
| 1   | 0   |
| 2   | 2   |
| 3   | 6   |
| 4   | 14  |
| 5   | 30  |
| 6   | 62  |
| 7   | 126 |
| 8   | 254 |
| 9   | 510 |
| 10  | 1022 |
| 11  | 2046 |
| 12  | 4094 |
| 13  | 8190 |
| 14  | 16382 |
| 15  | 32766 |
| 16  | 65534 |

.1

(Why subtract 2? - this is because the first address is a network address and the last address is a broadcast address)

2*6

Interesting octet value is the last octet that contains a 1 in it

Block size = 256 - Subnet's interesting Octet Value

in a 255.255.255.0 subnet mask, the block size is (256 - 255 = 1)

so then. you can count the network with a **Block Size of ==1==**:

172.20.==**1**==.0/24

172.20.==**2**==.0/24

172.20.**==3==.**0/24

....

172.10.==255==.0/24

Directed Broadcast address works by placing all 1's in the host bits e.g (172.20.1.0/24 has a directed broadcast of 172.20.1.255)

First usable IP is the network address +1, last usable is the broadcast address -1.

e.g 172.20.1.0/24

network address = 172.20.1.0 or 10101100.00011001.00000001.==**00000000**==

first usable host = 172.20.1.1 or 10101100.00011001.00000001==.**00000001**==

Last usable = 172.20.1.254 or 10101100.00011001.00000001.==**11111110**==

Broadcast = 172.20.1.255 or 10101100.00011001.00000001.==**11111111**==

Subnet table:

|     |     |
| --- | --- |
| Borrowed Bits | Number of subnets created with 2*S |
| 0   | 1   |
| 1   | 2   |
| 2   | 4   |
| 3   | 8   |
| 4   | 16  |
| 5   | 32  |
| 6   | 64  |
| 7   | 128 |
| 8   | 256 |
| 9   | 521 |
| 10  | 1024 |
| 11  | 2048 |
| 12  | 4096 |

SUPERNETTING Classless inter-domain routing (CIDR):

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Network address | Octet 1 | Octet 2 | Octet 3 | Octet 4 |
| 192.168.32.0/24 | ==11000000== | ==10101000== | ==001000==00 | 00000000 |
| 192.168.33.0/24 | ==11000000== | ==10101000== | ==001000==01 | 00000000 |
| 192.168.34.0/24 | ==11000000== | ==10101000== | ==001000==10 | 00000000 |
| 192.168.35.0/24 | ==11000000== | ==10101000== | ==001000==11 | 00000000 |

All highlighted networks have the first 22 bits in common, therefore: magic seen below (do this)

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Subnet Mask (Binary) | 11111111 | 11111111 | 11111100 | 00000000 |
| Subnet Mask (Decimal) | 255 | 255 | 252 | 0   |
| Network Address (Binary) | 11000000 | 10101000 | 00100000 | 00000000 |
| Network Address (Decimal) | 192 | 168 | 32  | 0   |