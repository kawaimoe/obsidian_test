# 1.2 SIEM Planning

**Calculating Log Aggregation:**

- When centralising the collecting logs, make sure hardware can take it
    
- Setup log aggregation to minimise bottleneck
    
- Make Proof of Concept, where you collect from a percentage of environment, this generates estimate of Events Per Second (EPS)
    
- alternative method is to calculate Events Per Day (EPD) by collecting from key systems like Windows or Linux
    

**Events per second:**

- Calculation: EPD (Events Per Day) / 86400 = EPS

**Peak Events per second:**

- To calculate for peaks calculate the normal working hours. e.g If you work 9 hours per day it would be: EPD / 32400 = EPS (32400 = 9 hours * 60 minutes in an hour * 60 seconds in a minute)
    
- it is bneficial to at least double the EPS calculated to ensure the acquired hardware can handle peaks.
    

**EPS recommendations:**

- Make sure to implement POC
    
- Use scripts to pull back EPS
    
- plan to over-purchase
    

**Storage Requirements (1)**

- Factors that make calculating storage requirement difficult:
    
    - Compression algorithms
        
    - Different devices generate different events and sizes
        
    - raw data vs modified data
        
    - storage format
        

**Storage requirement (2)**

- Requires a full POC to get accurate results
    
- Online studies can be of use when calculating size of events
    
- or set a constant for each type of system log, e.g 700 bytes per windows event or 300 bytes per firewall
    
- storage costs are getting cheaper per year
    

**Hot vs Warm data:**

- hot data is data defined by policy to be recent and will be stored on fast storage devices for quick analysis
    
- warm data was originally hot data that has expired its retention policy and needs to be moved on to archival media like HDD’s for a time stipulated by the organisations policy
    
- ideally an organisation should store data for at-least 30 days on hot disk and keep login events for an extended period (years)
    

**Key areas that can cause a SIEM to fail:**

- implementation without plan or roadmap:
    
    - *occurs when a SIEM is purchased for compliance and not for a need*
- Implementation without expertise
    
- Focus on only log collection and not analysis:
    
    - *orgs can start spending time purely collecting before moving on to analysis, this can kill the SIEM. Better to implement log collection process with analysis configuring process together.*
- Forgetting about people and time
    
    - *need enough people and enough training.*
- Implementation without use cases.
    
    - *Without establishing a use case prior to purchasing orgs can end up relying on what the vendor tells them its good fo*r

# Lab 1.0 DeTTect, Viuslize Visibility and Detection Capabilities

Command 1: starts dettect web app on local host inside a docker container

```bash
docker run -it --name dettect --rm -p 8081:8080 -v /labs:/labs:ro -v /home/student/Downloads:/opt/ DeTTECT/output -v /home/student/Downloads:/opt/DeTTECT/input hasecuritysolutions/dettect:1.4.2 /bin/ bash
```

Command 2: starts dettect command line inside terminal

***python dettect.py editor &***

Command 3: Converts generated yaml file into json for Mitre ATT&CK framework

```bash
python /opt/DeTTECT/dettect.py ds -fd /opt/DeTTECT/input/data-sources-new.yaml -l -- local-stix-path / labs/cti-ATT-CK-v8.2
```

- *ds= data source*
    
- *-fd= path to admin yaml file*
    
- *-l generate a data source layer for the ATT&CK navigator*
    
- *---local-sti\*\*X \**...=path to local stix repository to us DeTT&CT offline*
    

# SIEM Planning 1.4 Log Collection

### What makes up a SIEM?

- Log Collectors
    
    - agents or syslogs on systems that collect logs and send them to log aggregators
- Log Aggregators
    
    - Central point of collecting and parsing logs. Can also be used to generate alerts early on in log processing
- Lob Brokers
    
    - act as a buffer when log traffic is fluctuating. Ensure consistent flow of log data is sent to storage so that storage can handle the flow. (Optional)
- Storage
    
    - once logs processed they need to be stored. This is also where logs sit so that they are able to be searched.
- Search/Report
    
    - A node configured for searching and reporting on logs that are sitting in storage
- Alert engine
    
    - used to search for specific log entires and trigger based on alert conditions specified

### Log Collection

#### Types of logs agents:

- Auto parsing
    
- Data diode Support (one way communication)
    
- Pre-parsing
    
- Event rate controls
    
- Log rotation (Scheduled purges/moving to the archive of local logs)
    
- Log Buffering
    
- Server mode (some agents can act as collectors)
    
- Multiple destinations (logs can be delivered to multiple destinations with multiple transport protocols)
    
- etc….
    
- PAGE 45 book 555:1
    

#### Syslog

- Almost every system supports syslog,
    
- windows needs an agent however to support syslog
    
- uses UDP port 514
    
- New editions (RFC 5424) support TCP and TLS
    
- usually contains Timestamp, Source, Severity and message fields
    
- Facility describes where log came from (Numerical value)
    
- Severity describes importance of Logs (Numerical)
    

**Windows event logs vs syslogs**

- windows supports XML logs
- windows are much bigger than syslog per log event
- sending windows logs via syslogs causes errors

**Windows Event Forwarder and Event Collector**

- event forwarders can be deployed through GPO
- event collectors are best deployed between agent and aggregator

### **Third Party agents**

- multiple different features
- don't provide much support
- quality varies greatly
- Common open-source agents
    - Beats
    - NXLog
- no support from SIEM vendor
- best used when seem in licensed by EPS, use third party agent to filter good chunk of logs

**Performance Impact (agent vs agentless)**

- Agentless is supposed to perform better, however if an agent is configured correctly it can provide better performance due to agentless requiring remote authentication

AESPs (auto-start extensibility point)

- Commonly used for persistence
- it is a configuration point allowing program execution without explicit user calls
- a "hook-able configuration point" - [reference](https://www.serversource.co.uk/blogs/news/windows-startup-programs-security-threat "ServerSource Blogs")
- usually sitting in the Run or runonce registry key

## Log Aggregator

- Log aggregators are responsible for ingesting the log data sent from agents and start parsing/enriching and transporting the log data to either. a log broker or storage location

**Logstash**

<img src="../../../_resources/84075DA2-3633-429E-B618-A62F97278B47.jpeg" alt="84075DA2-3633-429E-B618-A62F97278B47.jpeg" width="394" height="191" class="jop-noMdConv">

**LogStash Input: Tags**

Can be useful for identifying different systems on different subnets

```logstash
input {
tcp {
port => 5000
tags => [ "cool", "test" ]
}
}
```

**Logstash Input: Codec**

```
input {
    tcp {
        port => 5000
        tags => [ "cool", "test" ]
        codec => json { charset => CP1252 }
}
}
```

### **Logstash input: Plugin stdin**

Enter the command below:
`logstash –e/ 'input { stdin { } } output { stdout { }}'`
2\. Wait for Logstash to start. You will know when you see Pipeline main started.
3\. Type the string Hello World and hit enter.
4\. See the result. It will contain the timestamp in UTC, followed by your system name, and then Hello
World.

### **Logstash input: plugin File**

```logstash
input {
    file {
        tags => "zeek_dhcp"
        sincedb_path => "/var/tmp/.zeek_dhcp_sincedb"
        path => "/usr/local/zeek/logs/current/dhcp.log"
}
}
```

The parameter sincedb_path
is simply a file that Logstash creates to remember where it last left off while monitoring the file.

Logstash input: plugin jdbc

Uses SL queries to pull from databases such as macafee EPO

```logstash
input {
    jdbc {
        jdbc_driver_library => 															"D:\temp\sqljdbc\sqljdbc_4.2\enu\sqljdbc42.jar"
        jdbc_driver_class => "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        jdbc_connection_string =>
"jdbc:sqlserver://mcafeeDB01;user=****;password=****;"
        jdbc_user => "****"
        jdbc_password => "****"
        statement => "SELECT AutoID AS
id,AutoGUID,ServerID,ReceivedUTC,DetectedUTC,AgentGUID,Analyzer,Analyz.....
```

Logstash input: plugin UDP/TCP:

```logstash
input {
    <udp or tcp> {
        port => 1514
    }
}
```

if you syslog doesnt let you send logs over different port other than 514 use thks command:

```bash
iptables -t nat -A PREROUTING -p UDP -m udp --dport 514 -j REDIRECT --to-
ports 1514
```

Logstash Output plgin: stdout

```logstash
output {
    stdout { }
}
```

or

```logstash
output {
    stdout { codec => rubydebug }
}
```

Logstash output plugin: Elasticsearch

```logstash
output {
    if "snort" in [tags] {
        elasticsearch {
            hosts => [ "10.0.0.1", "10.0.0.2", "10.0.0.3" ]
            ssl => true
            cacert => ‘/path/to/cert.pem’
            user => "username"
            password => "password"
            index => "logstash-snort-%{+YYYY.MM.dd}"
        }
    }
}
```

**Logstash output PLugin: Grok**

https://grokdebugger.com/

Alows you to pattern match with or without regex. Patterns are pre-built regex code matching a specific item.

```logstash
filter {
    grok {
        match => { "message" => "%{WORD:animal} is %{WORD:color}" }
    }
}
```

**% { WORD:animal}**

Here, WORD is the grok pattern item that you are trying to match and animal is the field name that you are assigning it too

### If a field is optionally present, use ()? For example:

Message: `The dog is brown and 7 years old`

here, the **"and 7 years old"** is an optional message.

Code:

```logstash
The %{WORD:animal} is %{WORD:color}( and
%{INT:age} years old)?
```

### Filter: CSV

```logstash
filter {
    csv {
        columns => ["animal","color","age"]
        separator => "|"
        source => "results"
    }
}
```

here the separd"results" instead of the normal "message" field

### Filter: Key Value (KV) 

Messages:

`animal=dog color=brown age=7`

`animal=cat color=orange age=4`

`animal=bird color=white age=6`

KV filter config:

```logstash
filter {
    kv {
    }
}
```

or 

```logstash
filter {
    kv {
    source => "data"
    value_split => ":"
    }
}
```

if **"="** is replaced with **":"**

### Filter plugin: JSON

Like KV but allows for nesting key-value pairs

```logstash
filter {
    json {
    source => "message"
    }
}
```

### Filter plugin: Drop

```logstash
filter {
    if [level] == "debug" {
    drop { }
    }
}
```

### Filter: remove_field

it is not a plugin by itself, but is a command used in each plugin. Most commonly used with "mutate" plugin.

```logstash
csv {
    columns => ["animal","color","age"]
    separator => "|"
    remove_field => [ "age" ]
}
```

**GeoIP:**

```logstash
geoip {
    source => "[SrcIp]"
    target => "SrcGeo"
}
```

DNS

```logstash
filter {
    mutate {
    add_field => { "DstIP-resolved" => "%{DstIp}" }
    }
    dns {
    reverse => [ "[DstIP-resolved]" ]
    action => "replace"
    }
}
```

### Fingerprinting:

used to protect sensitive information. Uses hashing algorithms  to hide the field.

```logstash
filter {
    fingerprint {
    	algorithm => "SHA512"
    	source =>[ "sensitive_field" ]
    	key => "BruteForceMeNowYouSillyRabbits"
    }
}
```

### Mutate:

```logstash
filter {
    mutate {
    lowercase => [ "name" ]
    }
}
```

many other commands, see docs for more info

### Renaming:

```logstash
filter {
    mutate {
        rename => { "IP" => "ip" }
        rename => { "IPv4" => "ip" }
    }
}
```

### Ruby code:

if the before-mentioned plugins do not do what you want ot do use ruby to write code that does what you need:

```logstash
ruby {
    code => "event.set('uri_length',
    event.get('uri').length)"
}
```