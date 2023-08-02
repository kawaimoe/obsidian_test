<img src="../_resources/Screenshot%202023-02-28%20at%2011.14.00.png" alt="Screenshot 2023-02-28 at 11.14.00.png" width="510" height="154">

- need a software-defined-network
- need remote access at both ends (role: router)
- need to manually start routing and remote-access)
- firewall rules:
    - inbound & outbound rules (routing an remote access GRE-out) are enabled
    - Powershell command
    - `PS C: \users \ Administrator> Add-VpnS2SInterface -Name"Users2Servers" -Destination 192.168.0.220 -grekey "1234" GreTunnel -SourceIpAddress 192.168.0.218 -IPV4Subnet "172.25.0.0/16:10" -PassThru`