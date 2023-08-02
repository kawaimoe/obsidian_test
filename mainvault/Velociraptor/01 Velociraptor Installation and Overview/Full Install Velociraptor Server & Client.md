# Full Install Velociraptor Server & Client

### SERVER:

#### 1. Get Velociraptor

**Online:**

* Navigate to https://github.com/Velocidex/velociraptor/releases and find latest version (e.g 0.6.9):
* Next use wget to grab latest install and output to '/usr/local/bin/velociraptor':

```
sudo wget https://github.com/Velocidex/velociraptor/releases/download/v$VER/velociraptor-v$VER-linux-amd64 -O /usr/local/bin/velociraptor
```

**Local:**

* locate latest velociraptor binary from given files, then copy into /usr/local/bin

```
sudo cp velociraptor_binary /usr/local/bin/velociraptor
```

#### 2. Make the velociraptor binary an executable:

```
sudo chmod +x /usr/local/bin/velociraptor
```

_NOTE: the binary will now be in path_

#### 3. Generate server config file:

```
mkdir /etc/velociraptor
cd /etc/velociraptor
velociraptor config generate -i
```

```
server: linux (kali machine)

datastore directory: default (press enter)

SSL/TLS: for now select "Self Signed SSL

frontend domain: default

ports: default, default

user: whatever you want (admin, Password1)

logstore path: default

server.config.yaml file?: /etc/velociraptor*

client config file?" /etc/velociraptor
```

#### 3. Edit the client and server config

```
nano /etc/velociraptor.config.yaml
```

**Find all instances of the following line**

```
bind_address: 127.0.0.1
```

_NOTE: if the bind address is set to 0.0.0.0, do not change this value_

**Then replace them with the following line:**

```
bind_address: your-server-ip 
```

_e.g: bind\_address: 192.168.1.5_

#### 4. Make a service with the config

```
sudo nano /lib/systemd/system/velociraptor.service
```

#### 5. Add the following lines:

```
[Unit]
Description=Velociraptor linux amd64
After=syslog.target network.target

[Service]
Type=simple
Restart=always
RestartSec=120
LimitNOFILE=20000
Environment=LANG=en_US.UTF-8
ExecStart=/usr/local/bin/velociraptor --config /etc/velociraptor.config.yaml frontend -v

[Install]
WantedBy=multi-user.target
```

#### 6. Save and close the file, then start up the service:

```
systemctl daemon-reload
```

```
systemctl enable --now velociraptor
```

#### 7. Check that its up and running

```
systemctl status velociraptor
```

* This will start the service at `https://<ip_of_box>:8889`

NOTE: to create additional users (this must be done while velociraptor is in use):

```
velociraptor --config /etc/velociraptor/server.config.yaml user add admin --role administrator
```

***

### Clients (Option 1)

#### 1. Generating Client msi package (linux):

In /etc/velociraptor directory:

`wget https://github.com/Velocidex/velociraptor/releases/download/v0.6.8-2/velociraptor-v0.6.8-windows-amd64.msi`

`velociraptor config repack --msi velociraptor-v0.6.8-2-windows-amd64.msi client.config.yaml output.msi`

`python -m http.server 9000`

#### 2. Installing from client (windows):

* open edge
* navigate to  _http://\<ip\_of\_box>:9000_
* download output.msi (windows defender hates this simple trick)
* in admin powershell:

```
mdkdir c:\users\<username>\velociraptor
cd ~\velocriaptor
mv ~\Downlaods\output.msi .
msiexec /i output.msi
```

_To check, open task manager, and try and find velociraptor.exe_

You should theoretically now have that host pop up in the VR admin console back on your linux box, if not read troubleshooting steps below

### Clients (Option 2)

#### 1. Download client.config.yaml file from python webserver

```
wget http://<server_ip>:9000/client.config.yaml
```

#### 2. Install service using powershell

```
.\velociraptor-v0.6.9-windows-amd64.exe --config client.config.yaml service install 
```

***

```
mkfdmkfdm
```

#### dsds

### sdsds

#### Troubleshooting:

* Clients not connecting 1:
  * open firewall settings and allow an exception for an application (velociraptor.exe), this should be located at "C:\Program Files\Velociraptor"
* Clients not connecting 2:
  * modifying host file
  * navigate to `C:\Windows\System32\drivers\etc\`
  * use notepad and modify host file, to point the hostname you specified in the config generation
* Server isn't starting 1:
  * double check the service config you made in step 5 of the server install instruction
* Server isn't starting 2:
  * google it
