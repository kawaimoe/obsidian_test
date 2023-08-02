What is Velociraptor:

- a DFIR tool that uses the VQL (Velociraptor Query Language)
- VQL is used for:
    - collecting info from clients,
    - monitoring and response
    - managing the velociraptor server

Inspo comes from two different projects:

- GRR
- OSQuery

![Screenshot 2023-05-06 at 15.35.09.png](../../_resources/Screenshot%202023-05-06%20at%2015.35.09.png)

Persistent communications with client

Server simply collects the results of queries - clients do all the heavy lifting,

### Recommendations:

- 10k - 15k clients - single servers with file based data store
    - SSL load is the biggest load - TLS offloading with load balancer helps.
    - 8GB ram/8 Corse is generous towards the top of the range
- Ubuntu/Debian server deployment recommended

### Self-signed SSL mode:

- Frontend served using TLS on port 8000 (connected to clients)
- GUI uses basic authentication with usernames/passwords.
- GUI Served over loopback port 8889 (127.0.0.1)
    - By default not exposed to the network
    - You can use SSH tunneling to forward the GUI

Velociraptor service has its own username

### Client/Server communications

The client and server coommunicate by sending each other messages (protocol buffers) They are sent using the https protocol ![Screenshot 2023-05-08 at 14.54.37.png](../../_resources/Screenshot%202023-05-08%20at%2014.54.37.png)

Before the client communicates with the server, the client must verify it is actually talking with the correct server. This happens at two levels:

- If the URL is a HTTPS URL then the TLS connection needs to be verified
    
- The client will fetch the url /server.pem to receive the server’s internal certificate. This certificate must be verified by the embedded CA.
    

Note that this verification is essential in order to prevent the client from accidentally talking with captive portals or MITM proxies.

### TLS verification

Velociraptor currently supports 2 modes for deployment via the config wizard:

- Self signed mode uses internal CAs for the TLS certificates. The client knows it is in self signed mode if the **Client.use\_self\_signed_ssl** flag is true.
    
- Proper certificates minted by Let’s encrypt.'
    

|     |     |
| --- | --- |
| ![Screenshot 2023-05-08 at 15.20.24.png](../../_resources/Screenshot%202023-05-08%20at%2015.20.24.png) | Server Status -  CPU and memory utilisation |
| ![Screenshot 2023-05-08 at 15.20.30.png](../../_resources/Screenshot%202023-05-08%20at%2015.20.30.png) |     |
| ![Screenshot 2023-05-08 at 15.20.36.png](../../_resources/Screenshot%202023-05-08%20at%2015.20.36.png) |     |
| ![Screenshot 2023-05-08 at 15.20.42.png](../../_resources/Screenshot%202023-05-08%20at%2015.20.42.png) |     |
| ![Screenshot 2023-05-08 at 15.20.57.png](../../_resources/Screenshot%202023-05-08%20at%2015.20.57.png) |     |
| ![Screenshot 2023-05-08 at 15.21.03.png](../../_resources/Screenshot%202023-05-08%20at%2015.21.03.png) |     |
| ![Screenshot 2023-05-08 at 15.21.08.png](../../_resources/Screenshot%202023-05-08%20at%2015.21.08.png) |     |
| ![Screenshot 2023-05-08 at 15.21.14.png](../../_resources/Screenshot%202023-05-08%20at%2015.21.14.png) |     |
| ![Screenshot 2023-05-08 at 15.21.20.png](../../_resources/Screenshot%202023-05-08%20at%2015.21.20.png) |     |
| ![Screenshot 2023-05-08 at 15.21.38.png](../../_resources/Screenshot%202023-05-08%20at%2015.21.38.png) |     |