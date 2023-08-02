## WinPEAS

enumerate the target system to uncover privilege escalation paths

`winpeas.exe > outputfile.txt`

https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS

* * *

## PrivescCheck

PrivescCheck is a PowerShell script that searches common privilege escalation on the target system. It provides an alternative to WinPEAS without requiring the execution of a binary file.

you may need to bypass the script execution policy (`Set-ExecutionPolicy`)

https://github.com/itm4n/PrivescCheck

* * *

## WES-NG: Windows Exploit Suggester - Next Generation

Some exploit suggesting scripts (e.g. winPEAS) will require you to upload them to the target system and run them there. This may cause antivirus software to detect and delete them. To avoid making unnecessary noise that can attract attention, you may prefer to use WES-NG, which will run on your attacking machine (e.g. Kali or TryHackMe AttackBox).

WES-NG is a Python script

https://github.com/bitsadmin/wesng

To use the script, you will need to run the `systeminfo` command on the target system. Do not forget to direct the output to a .txt file you will need to move to your attacking machine.

`wes.py systeminfo.txt`

* * *

## Metasploit

use: the "multi/recon/local\_exploit\_suggester"