# Installation Option with Internet

﻿

If you have internet access, the **wget** command brings the install package directly to your server:

1. Run: `wget -O splunk-8.0.5-a1a6394cc5ae-linux-2.6-x86_64.rpm '``https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.5&product=splunk&filename=splunk-8.0.5-a1a6394cc5ae-linux-2.6-x86_64.rpm&wget=true``'`
    
2. Use **Installation Option with rpm** on the next card.
    

# ﻿

# Installation Option with Repository

﻿

If you **do not** have internet access but have a repository available on the network, you can install via repository.

﻿

### Option 1

1. Run `yum install splunk`
    

### Option 2:

1. Run `apt-get install splunk`

# Splunk Data Ingest

Splunk can ingest data from a number of sources. Splunk can monitor files and directories, web traffic, email traffic, and more.

﻿

If an app is on your network, it’s most likely generating logs. Splunk can ingest those logs. Below are data source examples Splunk can ingest.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/8ba4a2c0-4946-4ae3-808f-20c87d62d17c?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5406ce4b7a448d0bbe23aa3b793e3c230c8150a173a52e8394f1ad0ff1642183)

﻿

### Indices and Buckets

﻿

In the process of ingesting data, Splunk breaks the data into time-stamped events and writes those events to an **index**.

﻿

An index is a collection of raw data files (in a compressed form) and index files. The index files contain metadata about the raw data. Splitting the metadata and raw data enables fast searching and analysis. The raw data files and index files are written into directories called **buckets**, which are organized by age.

﻿

### Fields

﻿

When you add data to the Splunk platform, the data is indexed. As part of the indexing process, some information is extracted from the input data and formatted as name and value pairs, called **fields**.

﻿

The fields extracted upon indexing are often limited to default fields. Splunk will later use fields to find and return data in any matching queries. Default fields like source, sourcetype, host, and index allow you to craft searches that narrow the scope of indexed data.

﻿

### Schema on Read

﻿

Because there are relatively few fields extracted at index time, Splunk uses a construct called **schema on read** to enhance the results returned. Schema on read is a data analysis strategy that applies data as it is pulled out, or searched, as opposed to when it is written (indexed). If required in certain use cases outside the scope of this module, Splunk can also be configured for schema on write.

﻿

### Leveraging Apps

﻿

Through the use of apps located on a Splunk search head (a Splunk instance installed to distribute searching to appropriate indexes), or a single instance, Splunk is able to extract additional, non-default fields that are applicable to a particular data source when that data is searched. Tailoring fields to specific data sources enables more robust searching and data analytics.

Continue

Click "Continue" to proceed to the next task.

# Search and Data Manipulation

With additional fields, you can learn interesting facts about the data.

﻿

### Learning New Facts from Added Fields

### ﻿

To determine how many failed attempts were registered on the www1 server compared to successful login attempts, you can leverage advanced search operators, which Splunk calls its Search Processing Language (SPL), to return statistics focused on the status field you previously created.

﻿

Below, you will **pipe** ( `|` ) your initial search to the **stats** operator. The stats operator includes the **count** function, which allows you to count the results by a given field. Because you previously added fields for source IP and status, you can manipulate the search results to provide more insights for login attempts over time.

﻿

1. Return to the **Search and Reporting** app by clicking the logo in the top left and selecting **Search and Reporting**.

﻿

2. Use the following query:

﻿

index="main" host="www1" sourcetype="secure" | stats count by status

﻿

3. Set the time to **All time**.

﻿

4. Click the Search icon to display the results, as shown below.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/411b869d-6042-4240-87b8-e4e0be2a7f9d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=32cb6a1a49b39be3fb71810e853f44e7f88fe771ef6ae060026582ce0f4d9d8c)

﻿

The search results include returned failures with **Failed** and **failed**. This means that getting accurate results requires a few extra steps.

﻿

### Using Eval

### ﻿

The eval command allows you to manipulate values which can be piped to the following functions. In this module, use eval to fix the "Failed" vs "failed" issue identified above by converting the status field to all lower case.

﻿

1. Use the following query to take all status results and make them lower case:

index="main" host="www1" sourcetype="secure" | eval status=lower(status) | stats count by status

2. Click the **Search** icon. The following results appear:

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/1a2c5a93-9c6a-47f4-b686-b1f61691e53e?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b8a110fe8da99591c55b52d86a2efcda1720718fd31692cfa367178aeb4be188)

﻿

3. Click **Visualization** to show this data as a visualization.

﻿

4. Choose **Pie Chart** in the drop-down menu.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/850da196-db73-4883-a0c5-a8d873f59e82?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=19a92236b97ffa82c6c6605d8e438c3ad57e99cbf6483194338a039979c29d35)

﻿

The resulting graph, in the image below, shows the majority of login attempts to **www1** were failures.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/8077fd1f-7338-4b43-95f3-6fe44f3f991b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fc7fd0a0740221eb2d1a6cd77e925f29e477ec89128c6b68436a4dd9f816e90f)

### ﻿

﻿

Continue

Click "Continue" to proceed to the next task.


# Scenario: Threat Hunting in Splunk ES

### Date: August 31, 2020

### Time: 11:30 am to 12:05 pm, EST

### Company: SOMECORP

### Role: Security Operations Center Analyst

﻿

In this section, you assume the role of a security operations center (SOC) analyst and examine two scenarios of malicious activity on the network.

﻿

### Scenario 1: DNS Exfiltration

﻿

In this technique, attackers send data out of a network through DNS queries, which are eventually routed to a server they control. Because all modern networks need some kind of DNS to be functional, this traffic is difficult to block. And with intelligent encoding, individual DNS requests may not look particularly suspicious.

﻿

To the benefit of threat hunters, DNS queries are small (they can not exceed 512 bytes). Therefore, in order to exfiltrate any significant amount of data with DNS requests, an attacker must send a large volume of them.

﻿

Use a Splunk correlation search that examines the number of DNS queries in a given time frame on a given host, to identify an anomalous incident and determine the origin.

﻿

### Scenario 2: Torrenting

﻿

Peer to Peer (P2P) torrenting is a subtle, but still malicious, activity. A normal download from a website involves a client requesting the file and the server providing the file for download. In contrast, torrenting involves using a client program to download a file or many files from multiple hosts at the same time, which increases download speeds significantly. The torrent client uses a blueprint of the file and requests all other clients on the network to provide small pieces of this file for download.

﻿

Examine the network traffic in the given time period. Then, examine network signatures of torrent traffic, and identify the files that were downloaded to the corporate host.

﻿

_NOTE: This section uses a different VM than you were using for Splunk ES configuration. If you are using the configuration VM from previous exercises, you will not see the relevant traffic._

Continue

Click "Continue" to proceed to the next task.


# Threat Hunting: DNS Exfiltration

Begin assessing the network’s security by browsing to the Incident Review dashboard within Enterprise Security.

﻿

Open the Linux hunt console in the VM Access Panel on the right.

﻿

### Log In To Splunk

1. On the desktop, double-click the Splunk icon.
    
2. Log in to Splunk.
    
3. Click **Apps:** and select **Enterprise Security** .
    
4. Click **Incident Review** .
    
5. Set the time frame to August 31, 2020 between 11:30 am and 12:05 pm .
    
6. Click **Apply,** then **Submit**.
    
7. Examine the output for the given time period.
    

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/93a16d43-58ee-41a5-980c-fce66a95893d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=43c494e53f988171d832107efcbfe34508de2260e927ddd8fd65b072e29d6684)

﻿

The Incident Review has flagged an event with the DNS tunneling ruleset. You can further examine this incident to see the specifics.

### Examine Flagged Event

1. Expand the event’s fields.
    
2. Read the description of the rule’s criteria.
    

The rule examines DNS events by calculating the sum of the length of DNS queries and answers. It assigns a specific risk score based on the result of these correlation searches.

﻿

In this example, the event was flagged because DNS queries were excessive. The resulting risk score is 'Medium', indicating that a suspicious event has occurred. Splunk calculates Urgency ratings based on assets and identities set by an administrator, which you configured earlier in this module.

﻿

Below is a screenshot of assets loaded earlier in the module. After this module is completed, feel free to play around with priorities and rerun the correlation search to see how it affects urgency. However, to facilitate correctly answering knowledge checks later in the module, do not make any changes at this time.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/1455949c-cdda-4d6c-97c8-be374248626d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c668469ca4f81d720fcf99fac55512509257c3a2d7653b5b966a4f0d1854cb09)

﻿

### Correlate the Suspicious Event

﻿

Using the IP of the host that the event has flagged, go to the Search application within Enterprise Security and correlate this event against the logs from that system:

1. From the main menu bar at the top, select **Search** > **Search .**
    
2. Enter: `index=* search_name="ESCU - Detection of DNS Tunnels - Rule"`
    

﻿

Continue

Click "Continue" to proceed to the next task.