The SUID bit set for the nano text editor allows us to create, edit and read files using the file owner’s privilege. Nano is owned by root, which probably means that we can read and edit files at a higher privilege level than our current user has

use this command below to find files with the SUID bit set:

`find / -type f -perm -04000 -ls 2>/dev/null`

Then look on <ins>https://gtfobins.github.io</ins> to find a match for a binary to exploit