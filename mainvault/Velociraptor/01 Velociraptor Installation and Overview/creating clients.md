`velociraptor-windows.exe config repack --msi velociraptor-v0.6.8-2-windows-amd64.msi client.config.yaml output.msi`

(NOTE: if local setup without a DNS server installed modify the host file of the client config to reflect the ip address of the velociraptor service)![Screenshot 2023-05-08 at 14.37.45.png](../../_resources/Screenshot%202023-05-08%20at%2014.37.45.png)

`msiexec /i velociraptor.msi`