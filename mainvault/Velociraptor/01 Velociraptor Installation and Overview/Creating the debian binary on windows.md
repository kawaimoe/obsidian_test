`./velociraptor-v0.5.5-windows.exe --config ~/server.config.yaml debian server --binary velociraptor-v0.5.5-linux-amd64`

move the file to the debian server

then:

sudo dpkg -i &lt;debian file&gt;

sudo apt install -f