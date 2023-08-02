- an Exterior Gateway Protocol (EPG)
- a Path vector Routing Protocol

<img src="../_resources/Screenshot%202023-02-27%20at%2013.50.38.png" alt="Screenshot 2023-02-27 at 13.50.38.png" width="453" height="241">

commands:

>conf term
>bgp 64500
>neighbor 198.51.100.2 remote-as 64495
>network 192.0.2.0 mask 255.255.255.0
<img src="../_resources/Screenshot%202023-02-27%20at%2014.24.35.png" alt="Screenshot 2023-02-27 at 14.24.35.png" width="444" height="132">

To check:

\> show ip bgp