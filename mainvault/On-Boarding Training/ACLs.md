- filtering ACl has to be applied with 'in' or 'out' keyword
- permit or deny
- Types:
    - named
    - numbered
- processed from top down
- deny any = deny everything
- permit any = permit everything

ACl configured to allow 100.64.0.2

1 = ACL number group

remark user = remark about ACL

<img src="../_resources/Screenshot%202023-02-28%20at%2012.35.52.png" alt="Screenshot 2023-02-28 at 12.35.52.png" width="492" height="116" class="jop-noMdConv">

wildcard masks:

access-list 1 deny 100.64.0.0 0.0.0.255 <---- (denies all ip addresses in the /24 ip range)

Applying an ACL to an interface

1 = ACL number group

<img src="../_resources/Screenshot%202023-02-28%20at%2012.41.03.png" alt="Screenshot 2023-02-28 at 12.41.03.png" width="399" height="206" class="jop-noMdConv">

**testing:**

**show ip access-lists**

- Extended ACls
    - number ranges: 100-199 and 2000-2699
    - protocols can be specified: TCP, UDP, ICMP, IP and so on

![Screenshot 2023-02-28 at 12.45.07.png](../_resources/Screenshot%202023-02-28%20at%2012.45.07.png)

101 = access list number

icmp = protocol

any(1) = any source

any(2) = any destination

Setting host to extended ACL:

![Screenshot 2023-02-28 at 12.46.36.png](../_resources/Screenshot%202023-02-28%20at%2012.46.36.png)

- Extended ACL ports
    - logic for equal to, not equal to, less than, greater than and range of ports
    - `access-list number [permit  deny} [tcp | udp] src-address src-wildcard`

Using 'eq' command

![Screenshot 2023-02-28 at 12.51.18.png](../_resources/Screenshot%202023-02-28%20at%2012.51.18.png)

- Named ACLs

Standard list

<img src="../_resources/Screenshot%202023-02-28%20at%2012.53.52.png" alt="Screenshot 2023-02-28 at 12.53.52.png" width="538" height="162">

filter-dmz-in = ACL name

Extended named list:

![Screenshot 2023-02-28 at 12.55.39.png](../_resources/Screenshot%202023-02-28%20at%2012.55.39.png)

how to remove entry:

(be inside access-list config)

do show access-lists

remove {number}