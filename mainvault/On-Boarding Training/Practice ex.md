192.168.0.0/24

apply a /26 subnet mask

What are the subnets and whate are the usable address ranges in each subnet

|     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |

2*2 = 4 or 11000000

/24 + /2 = /26 and (255.255.255.192 =  6 host bits

2*6 - 2 = 62 available host bits per subnet

Interesting octet value is the last octet that contains a 1 in it

Block size = 256 - Subnet's interesting Octet Value (192)

in a 255.255.255.192 subnet mask, the block size is (256 - 192 = 64)

so then. you can count the network with a **Block Size of 64**:

192.168.0.0/26

192.168.0.64/26

192.0.0.128/26

192.168.192/26

|     |     |     |
| --- | --- | --- |
| Subnet | Directed broadcast | Usable range of IP addresses |
| 192.168.0.0 | 192.168.0.63 | 192.168.0.1 - 192.168.0.2 |
| 192.168.0.64 |     |     |
| 192.168.0.128 |     |     |

network address = 192.168.0.64/26 or 10101100.00011001.00000001.==**01000000**==

first usable host = 192.168.0.65/26 or 10101100.00011001.00000001.**01000001**

Last usable = 192.168.0. or 10101100.00011001.00000001.0**1111110**

Broadcast = 172.20.1.255 or 10101100.00011001.00000001.0**1111111**

Calculation template

IP ADDRESS: 172.16.56.0 /21 class C

**/21 = 11111111.11111111.11111000.00000000 = 5 borrowed bits **

**128 + 64  + 32 +16 + 8 = 248

**256 - 240 = 8 <---- BLOCK SIZE**

**IP start(optional): 172.16.0.0/21**

..0.0 = ..0.1 - 7.254.

..8.0 = ..8.1 - 15.254

..16.0 = 16.1 - 23.254

..24.0 = 24.1 - 31.254

..32.0 = 32.1 - 39.254

..40.0 = 40.1 - 47.254

..48.0 = 48.1 - 55.254

..56.0 = 56.1 - 63.254 <---- B &C

..........

/13 = 11111111.11111000 = 128 + 64 + 32 + 16 + 8 = 248