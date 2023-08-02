Fixing update failure:
The steps for setting up a PVE no subscription configuration is configured using the etc apt sources.list.d file found at:**/etc/apt/sources.list**

Add the following line in the /etc/apt/sources.list file:**deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription**

Next

Now, we just need to comment out a line in another file located here:**/etc/apt/sources.list.d/pve-enterprise.list****Next**

**apt-get update**

**Next**

**apt dist-upgrade**