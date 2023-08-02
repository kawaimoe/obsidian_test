**Script Collections:**

- [[Processes]]
- [[Services (hash, path)]]
- [[Users & Groups (local, AD)]]
- [[Ports open]]
- [[Firewall rules]]
- [[Wmic]]
- [[Network shares]]
- [[Computer info]]
- [[Peripheral devices]]
- [[Registry (autoruns)]]
- [[GPO objects + settings]]
- [[AD schema]]
- [[Open connections]]
- Enumeration of /temp [[directories]] or other common drop locations
- …and [[anything else]] you may deem necessary.

**Guidance:**

- Members should write the above script to be efficient in resource usage, including time. It is also noted that the above collection vectors should be function based, with the return for functions being CSV based. A master output should be produced within the XX? format.
- Members need to consider the lifespan of this collection effort, ie: should the script be run on a scheduled task, and should the script be aware of previous collections and determine difference between the attempts to display possible malicious artifacts to operators?
- Members need to be aware that the script needs to be designed to run on multiple remote hosts in a network, and scale accordingly.
- Members should not use profiles for scripts.