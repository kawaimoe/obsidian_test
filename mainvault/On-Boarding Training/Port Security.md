- default to learn on AC address on each port-first come, first learned
- default violation is to shutdown ports

Default config:

<img src="../_resources/Screenshot%202023-02-28%20at%2013.21.45.png" alt="Screenshot 2023-02-28 at 13.21.45.png" width="607" height="176">

set maximum devices on any one port:

<img src="../_resources/Screenshot%202023-02-28%20at%2013.23.01.png" alt="Screenshot 2023-02-28 at 13.23.01.png" width="749" height="58">

Set to drop if past maximum device count:

![Screenshot 2023-02-28 at 13.23.44.png](../_resources/Screenshot%202023-02-28%20at%2013.23.44.png)

once swithc or router reboots it will forget config unless **sticky** command is used

statically configure mac address:

<img src="../_resources/Screenshot%202023-02-28%20at%2013.21.45.png" alt="Screenshot 2023-02-28 at 13.21.45.png" width="624" height="181">

testing:

>show port-s int {int name}