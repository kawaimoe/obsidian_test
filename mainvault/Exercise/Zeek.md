# Logs
## 1. conn.log

﻿

The conn.log summarizes TCP/UDP/ICMP connection details and provides additional information about the connection history and service.

﻿

**Using this log:**

Use the conn.log as a starting point to investigate network activity, whether troubleshooting network problems or collecting information on anomalous activities.

﻿

**A.** The Unique Identifier (UID) provides a primary key to conduct link analysis with other related logs, such as pivoting to the SSL log for server_name.

﻿

**B.** Zeek parses the protocol to determine the service regardless of the port, such as HTTP traffic traversing over port 8080.

﻿

**C.** The responding bytes field provides the total bytes transferred by the responding host during the connection.

﻿

**D.** The conn.log records the connection state history. For example, reconnaissance may show multiple SYN and RST packets only since the attacker looks for open services.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/4883ec95-860c-561f-b45a-ea01f4c5770d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3a7c5d511aa51839584fa30f6a4ff68fb2a114e87e0719f4384ee09620853e43)

# **2. smb_files.log**

The smb_files.log describes transactions over the SMB protocol, commonly used in Microsoft environments for transferring files across network shares such as to home directories.

﻿

**Using this log:**

Network and security engineers may use the smb_files log to investigate files copied via Microsoft SMB.

﻿

**A.** The UID provides a primary key to conduct link analysis with other related logs.

﻿

**B.** The File Unique Identifier (FUID) provides a key for link analysis with other file-related logs.

﻿

**C.** The Universal Naming Convention (UNC) of the file accessed.

﻿

**D.** The name of the file.

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/8f713f06-ff05-5cc3-84cf-4c6b82ea1422?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=60f365c510a5452339c5e3afedd1d4b90d27d47649db11c84ca01d73c1ddd7d0)

# **3. dce_rpc.log**

﻿

The Distributed Computing Environment Remote Procedure Call (DCE_RPC) log parses the Distributed Component Object Model (DCOM), which is a proprietary Microsoft software component that allows COM objects to communicate over a network.

﻿

**Using this log****:**

**A.** The UID provides a primary key to conduct link analysis with other related logs.

﻿

**B.** A preassigned, network-specific, stable address for a particular Microsoft named client or server instance (i.e., iTaskSchedulerService)

﻿

**C.** The Microsoft operation being performed, mapped from the Microsoft’s Universal Unique Identifier (UUID).

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/8b6ce8a5-2564-5520-b085-4e68fab1da68?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=e44de8c5827dad7cf196617ba6fd68d6a66bc9e99da02faeaa35c4217193bd63)

**NOTE:** The attached Zeek Log Info Sheets contain fields, types, and descriptions for numerous other default Zeek logs.

﻿

By default, RockNSM writes Zeek data logs directly in **ASCII** format to the /data/zeek/logs/current directory.

﻿

![](https://rcs06-minio.pcte.mil/portal-bucket/portal/learning-server/rich-content-images/e19afd86-71ed-5ff1-abca-4a3f42365c17?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=PCTE-SimSpaceCorp%2F20230610%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230610T000000Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=666e58007d8f4e0ddb8175a08fd56a3ce4628a0f8a9e034e96ec6bf9f3d9f8ef)

﻿

As mentioned previously, RockNSM also simultaneously writes data logs in **JSON** format to Kafka topics.