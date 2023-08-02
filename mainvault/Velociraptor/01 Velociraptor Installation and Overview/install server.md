### Simple server setup (localhost)

got to github and find latest verison (0.6.8-2):

make variable:

`VER=0.6.8-2`

next use wget to grab latest instal and output to '/usr/local/bin/velociraptor':

`wget https://github.com/Velocidex/velociraptor/releases/download/v$VER/velociraptor-v$VER-linux-amd64 -O /usr/local/bin/velociraptor`

make the velociraptor binary an executable:

`chmod +x /usr/local/bin/velociraptor`

the binary will now be in path

Generate server config file:

Velociraptor uses a pair of configuration files to control the server and endpoints. To generate server configuration file, you can use the command

`velociraptor config generate --help`
You can run the command interactively or you can run it non-interactively and later customize the auto-generated configuration file.

however: Before we proceed, create a configuration directory for Velociraptor;

`mkdir /etc/velociraptor`

`cd /etc/velociraptor`
`velociraptor config generate -i`

![Screenshot 2023-05-06 at 17.29.16.png](../../_resources/Screenshot%202023-05-06%20at%2017.29.16.png)

![Screenshot 2023-05-06 at 17.29.39.png](../../_resources/Screenshot%202023-05-06%20at%2017.29.39.png)

Now start velociraptor with:

`velociraptor -c /etc/velociraptor/server.config.yaml gui -v`

this will start the service at `https://127.0.0.1:8889`

to create additional users (this must be done while velociraptor is in use):
`velociraptor --config /etc/velociraptor/server.config.yaml user add admin --role administrator`

(NOTE: default user and password is:
admin
password

no you should be able to login to the local host with the above user added

minecraft-server.velociraptor