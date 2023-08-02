radius/TACACS+ commands

(enable AAA services in global config)

```cisco
>conf t

>aaa new -model

(connect to external TACACS+ server)

>username {insert local username} privilege 15 secret cisco <----(create this as a fallback method)

(config-server-tacacs)>tacacs server {name it}

(config-server-tacacs)>address ipv4 {tacacs server address}

(config-server-tacacs)>key {pre-made tacacs key}

(config-server-tacacs)

>exit

>aaa group server tacacs+ {name group}

server name {TACACS server-name}

aaa authentication login {default or WORD}

aaa authentication login default group {named group}

aaa authentication login default group {named group} local enable (enables login for group)

aaa authorization exec default group {named group} local (enables exec functions)
```

TEST:

```cisco
logout
```

then log back in with created user