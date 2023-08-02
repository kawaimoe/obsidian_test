You need to log creation/modification/deletion of containers from services like Docker or AWS

You need to collect Docker/AWS logs themselves for an overview of what is happening to platform.

Then, problem is when modifying/deleting containers themselves, this will delete those logs.
solution is deploying one of four methods for collecting logs from containers.

- persistent data volume or bind mount
    - have a location on host OS that logs, from containers, are shipped to
- Application Inside Container, 
    - use app logs from containers to directly ship to SIEM
- Monitoring container (sidecar)
    - have a container made specifically to collect logs from other containers (clown face)
- Daemon log drivers,
    - in-built drivers for either Docker or AWS that ship logs to NFS drive or use a network service to ship