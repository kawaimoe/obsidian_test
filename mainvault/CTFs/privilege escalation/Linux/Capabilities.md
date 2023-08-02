Another method system administrators can use to increase the privilege level of a process or binary is “Capabilities”. Capabilities help manage privileges at a more granular level. For example, if the SOC analyst needs to use a tool that needs to initiate socket connections, a regular user would not be able to do that. If the system administrator does not want to give this user higher privileges, they can change the capabilities of the binary. As a result, the binary would get through its task without needing a higher privilege user

use this command to find user capabilites:

`getcap -r / 2>/dev/null`

Then look on <ins>https://gtfobins.github.io</ins> to find a match for a binary to exploit