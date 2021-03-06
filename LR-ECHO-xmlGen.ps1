﻿param(
  [Parameter(Mandatory=$true)]
  [string]$InputFile = "Apache_Attack.txt",
  [Parameter(Mandatory=$false)]
  [string]$UseCaseId = 99,
  [Parameter(Mandatory=$false)]
  [string]$UseCaseTitle = "My ECHO Use Case",
  [Parameter(Mandatory=$false)]
  [string]$UseCaseDescription = "The. Best. Demo. Ever.",
  [Parameter(Mandatory=$false)]
  [string]$LogDescription = "PAM - Login Failure",
  [Parameter(Mandatory=$false)]
  [string]$ReplayMessage = "Syslog - Linux Host",
  [Parameter(Mandatory=$false)]
  [string]$MsgSrcId  = "88",
  [Parameter(Mandatory=$false)]
  [string]$MsgSrcName = "Syslog - Linux Host"
)

if(Test-Path -Path $InputFile){
    $log= Get-Content $InputFile
}else{
    write-output "$InputFile not found."
    exit
}

try{

    $header = @("<ReplayData>
  <UseCase UseCaseId=`"$UseCaseId`" Title=`"$UseCaseTitle`" Description=`"$UseCaseDescription`" />")

    $footer = @("</ReplayData>
")


    $epoch = Get-Date -format 'yyyyMMdhhmmss'

    $tempFileName = "UseCase_" + $UseCaseId + ".xml"  

    $finalFileName = $($UseCaseTitle.replace(' ','') + "_" + $UseCaseID + "_" + (Get-Date -format 'yyyyMMdhhmmss'))

    $temp = @()

    $temp += $header

    foreach($line in $log){
    
        $temp +=  "  <Log Description=`"$LogDescription`" Message=`"$ReplayMessage`" MsgSrcId=`"$MsgSrcId`" MsgSrcName=`"$MsgSrcName`">$([System.Security.SecurityElement]::Escape($line))</Log>" 

    }

    $temp += $footer

    $temp | out-file $tempFileName
    
    sleep 1

    Compress-Archive -Path $tempFileName -DestinationPath $finalFileName
    
    sleep 1
    
    Remove-Item -Path $tempFileName
    
    write-output "Successfully written to $finalFileName.zip" 

}catch{
    $ErrorMessage = $_.Exception.Message
    write-host $ErrorMessage 
}

<###

MsgSourceTypeID	Name
2	LogRhythm File Monitor (Linux)
3	LogRhythm File Monitor (Windows)
4	LogRhythm Syslog Server (Windows)
5	LogRhythm Syslog Server (Linux)
6	LogRhythm File Monitor (Solaris)
7	LogRhythm Netflow Server (Windows)
8	LogRhythm File Monitor (AIX)
10	LogRhythm Test File - IDS Alarms
11	LogRhythm Test File - System Log
12	LogRhythm Test File - Audit Log
13	Syslog File - LogRhythm Syslog Generator
15	LogRhythm Test File - Firewall
21	Flat File - Microsoft ISA Server W3C File
23	MS Event Log for XP/2000/2003 - Security
30	MS Event Log for XP/2000/2003 - System
31	MS Event Log for XP/2000/2003 - Application
32	MS Event Log for XP/2000/2003 - Directory Service
33	MS Event Log for XP/2000/2003 - File Rep Service
35	Syslog File - BSD Format
37	Flat File - Snort Fast Alert File
38	Flat File - X-NetStat Log
40	Flat File - Microsoft SQL Server 2000 Error Log
76	MS Event Log for XP/2000/2003 - DNS
80	Flat File - Apache Error Log
81	Flat File - Apache Access Log
82	Flat File - Apache SSL Error Log
83	Flat File - Apache SSL Access Log
84	Flat File - Microsoft IIS W3C File
85	Syslog - Cisco Switch
86	Syslog - Cisco Router
87	Syslog - Cisco PIX
88	Syslog - Linux Host
89	Syslog - HP-UX Host
90	Syslog - AIX Host
91	Syslog - Solaris Host
92	Syslog - Other
93	Syslog - Cisco NIDS 
94	Flat File - MS Exchange 2003 Message Tracking Log
95	Flat File - Blue Coat Proxy CSV Format
100	Syslog - Autoregistered
101	Netflow - Cisco Netflow Version 1
102	Netflow - Cisco Netflow Version 5
103	Syslog File - Linux Host
104	Syslog File - Solaris Host
105	Syslog - LogRhythm Syslog Generator
106	Syslog - SonicWALL
107	Syslog - NetScreen Firewall
108	Syslog - Network Chemistry RFprotect
109	Flat File - VMWare Virtual Machine
110	Syslog - Apache Tomcat Request Parameters
111	Flat File - Microsoft IIS NCSA Common Format File
112	Flat File - Microsoft IIS (IIS Format) File
113	Syslog - Sophos UTM
114	Syslog - Symbol Wireless Access Point
115	Flat File - HP-UX Audit Log
116	Syslog - Cisco VPN Concentrator
117	Syslog - BSD Host
118	Syslog - IRIX Host
119	Flat File - Microsoft Windows Firewall
120	Syslog - Solaris (Snare)
121	Flat File - MS IAS/RAS Server NPS DB Log Format
122	Flat File - Microsoft DHCP Server Log
123	Syslog - Enterasys Router
124	Syslog - Enterasys Switch
125	OPSEC LEA - Checkpoint Firewall
126	OPSEC LEA - Checkpoint Log Server
127	Flat File - Other
128	Syslog - Active Scout IPS
129	Syslog - Watchguard FireBox
130	Syslog - Fortinet FortiGate
131	Flat File - Avaya Voice Mail Log
132	Syslog - Barracuda Spam Firewall
133	Flat File - Sendmail File
134	Flat File - JBoss Log File
135	Flat File - Vormetric Log File
136	Syslog - McAfee Secure Internet Gateway
137	Syslog - SonicWALL SSL-VPN
138	Flat File - Tandem EMSOUT Log File
139	Flat File - Cisco Secure ACS CSV File
140	Syslog - Barracuda Webfilter
141	Syslog - Proofpoint Spam Firewall
142	Flat File - Verint Audit Trail File
143	Syslog - Tipping Point IPS
144	Syslog - Aruba Mobility Controller
145	Syslog - AirTight IDS/IPS
146	Flat File - IBM ZOS Batch Decryption Log
147	Flat File - IBM ZOS CICS Decryption Log
148	Flat File - IBM ZOS RACF Access Log
149	Syslog - IBM 4690
150	Syslog - Airwave Management System Log
151	MS Event Log for XP/2000/2003 - BioPassword
152	UDLA - Oracle 10g Audit Trail
153	Syslog - Gene6 FTP
154	Flat File - Gene6 FTP
155	Syslog - Bradford Remediation & Registration Svr
156	Flat File - MS ISA Server 2006 W3C All Fields
157	Flat File - MS ISA Server 2006 ISA All Fields
158	UDLA - McAfee ePolicy Orchestrator 3.6 - Events
159	Flat File - XPient POS CCA Manager
160	Syslog - HP Procurve Switch
161	Flat File - Microsoft IIS FTP W3C Extended Format
162	Syslog - Cisco ASA
163	Syslog - Cisco FWSM
164	Flat File - BlackBerry Enterprise Server
165	Syslog - Consentry NAC
166	Syslog - Blue Coat ProxySG
167	Flat File - Blue Coat Proxy SQUID-1 Format
168	Syslog - Nortel Firewall
169	Syslog - Nortel Passport Switch
170	Airwave Management System
171	Syslog - Nortel BayStack Switch
172	Flat File - PICIS MedTech CareSuite OR Manager
173	Flat File - MS Exchange 2007 Message Tracking Log
174	Syslog - Citrix Netscaler
175	Flat File - IBM ZOS RACF SMF Type 80
176	Flat File - Symantec Antivirus 10.x Corporate Edtn
177	Syslog - Airmagnet Wireless IDS
178	Syslog - AS/400 via Powertech Interact
179	Syslog - F5 FirePass Firewall
180	Syslog - Sygate Firewall
181	Syslog - Symantec DLP
182	Syslog - AirDefense Enterprise
183	Syslog - Brocade Switch
184	Syslog - iSeries via Powertech Interact
185	Flat File - MongoDB
186	Syslog - Juniper SSL VPN
187	Flat File - Microsoft ISA Server 2004
188	Syslog - F5 Big-IP GTM & DNS
189	Syslog - EqualLogic SAN
190	Syslog - RSA ACE
191	Netflow - Palo Alto Version 9
192	Syslog - Tripwire
195	Syslog - Cisco Router IOS 12.4
196	Syslog - Cisco Switch IOS 12.4
197	Syslog - LogRhythm Network Monitor
198	Syslog - Wurldtech SmartFirewall
199	MS Event Log for XP/2000/2003 - SafeWord 2008
1000000	Syslog - VMWare ESX/ESXi Server
1000001	Syslog - McAfee Firewall Enterprise
1000002	Syslog - Cisco Aironet WAP
1000003	Flat File - Blue Coat Proxy W3C Format
1000004	Syslog - Black Diamond Switch
1000005	Syslog - Allied Telesis Switch
1000006	Syslog File - AIX Host
1000007	Flat File - Oracle 9i
1000019	Syslog - Snort IDS
1000020	UDLA - Forcepoint
1000021	Syslog - Cisco Email Security Appliance
1000022	Flat File - Citrix Access Gateway W3C Format
1000023	Flat File - Citrix Access Gateway NCSA Common Format
1000024	Flat File - Citrix Access Gateway IIS Format
1000025	API - Cisco IDS/IPS
1000026	Syslog - Juniper Router
1000027	Syslog - MS IIS Web Log W3C Format (Snare)
1000028	Syslog - Snare Windows 2003 Event Log
1000030	MS Windows Event Logging - Security
1000031	MS Windows Event Logging - System
1000032	MS Windows Event Logging - Application
1000033	Flat File - RACF (SMF)
1000034	UDLA - ISS Proventia SiteProtector - IPS
1000035	Flat File - DB2 Audit Log
1000036	Syslog - McAfee Network Security Manager
1000037	Syslog - Juniper Switch
1000038	MS Event Log for XP/2000/2003 - SMS 2003
1000039	Syslog File - MS 2003 Event Log (Snare)
1000040	UDLA - Oracle 9i Audit Trail
1000041	Flat File - Lotus Domino Client Log
1000042	Flat File - vsFTP Daemon Log
1000043	Flat File - Solaris - Sulog
1000044	LogRhythm Data Loss Defender
1000045	Syslog - Juniper Firewall
1000046	Syslog - Event Reporter (Win 2000/XP/2003)
1000047	Flat File - SpamAssassin
1000048	Syslog - Top Layer IPS
1000049	Flat File - McAfee Foundstone
1000050	Syslog - Foundry Switch
1000051	Syslog - McAfee Email And Web Security
1000052	Flat File - ClamAV Anti-Virus
1000053	Syslog - Juniper IDP
1000054	Flat File - Microsoft IIS URL Scan Log
1000055	UDLA - McAfee Network Access Control
1000056	Flat File - Apache Tomcat Access Log
1000057	Syslog - HP Router
1000058	Syslog - Extreme Wireless LAN
1000059	LogRhythm User Activity Monitor (Windows)
1000060	LogRhythm User Activity Monitor (Linux)
1000061	LogRhythm User Activity Monitor (Solaris)
1000062	LogRhythm User Activity Monitor (AIX)
1000063	Syslog - Cisco ACS
1000064	Syslog - Cisco CSS Load Balancer
1000065	Syslog - Trustwave Web Application Firewall
1000066	Flat File - MS SQL Server Reporting Services 2008
1000067	Flat File - Tumbleweed Mailgate Server
1000068	Syslog - Cisco Global Site Selector
1000069	MS Event Log for XP/2000/2003 - HA
1000070	Flat File - Squid Proxy
1000071	Syslog - Oracle 10g Audit Trail
1000072	Syslog File - Oracle 10g Audit Trail
1000073	MS Event Log for XP/2000/2003 - PatchLink
1000074	Syslog - Safenet
1000075	MS Event Log for XP/2000/2003 - Virtual Server
1000076	Syslog - WS2000 Wireless Access Point
1000077	Syslog - Symantec Endpoint Server
1000078	Syslog - Tumbleweed Mailgate Server
1000079	UDLA - McAfee ePolicy Orchestrator 4.0 - ePOEvents
1000080	Syslog - Sourcefire IDS 3D
1000081	Syslog - Nortel 8600 Switch
1000082	Syslog - Juniper Host Checker
1000083	MS Event Log for XP/2000/2003 - DotDefender
1000084	Flat File - Bind 9
1000085	Syslog - Protegrity Defiance DPS
1000086	Flat File - Citrix Presentation Server
1000087	Flat File - ProFTPD
1000088	Syslog - Generic ISC DHCP
1000089	Syslog - InfoBlox
1000090	UDLA - Sophos Anti-Virus
1000091	Flat File - Siemens Radiology Information System
1000092	Syslog - McAfee SecureMail
1000093	Syslog - RuggedRouter
1000094	Flat File - Cisco Security Agent
1000095	Syslog - iPrism Proxy Log
1000096	Syslog - HP Unix Tru64
1000097	Syslog - CodeGreen Data Loss Prevention
1000098	Flat File - Meridian
1000099	Flat File - Swift Alliance
1000100	Syslog - Zimbra System Log
1000101	Syslog - Cisco Wireless Control System
1000102	MS Event Log for XP/2000/2003 - Kaspersky
1000103	Syslog - Checkpoint IPS
1000104	Syslog - Fidelis XPS
1000105	Syslog - Postfix
1000106	Flat File - Microsoft CRM
1000107	Flat File - Cisco NGFW
1000108	Syslog - NetApp Filer
1000109	Flat File - IBM 4690 POS
1000110	Flat File - Novell Audit
1000111	Syslog - Juniper SSL VPN WELF Format
1000112	MS Event Log for XP/2000/2003 - DFS
1000113	Flat File - Blue Coat Proxy BCREPORTERMAIN Format
1000114	Flat File - Trade Innovations CSCS
1000115	Flat File - Kerio Mail Server
1000116	Flat File - Solaris Audit Log
1000117	Flat File - Irix Audit Logs
1000118	Syslog - Dell PowerConnect Switch
1000119	MS Windows Event Logging - Dir Service
1000120	MS Windows Event Logging - DNS
1000121	MS Windows Event Logging - DFS
1000122	MS Windows Event Logging - Replication
1000123	Flat File - Linux Audit Log
1000124	Flat File - Epicor Coalition
1000125	Syslog - Dialogic Media Gateway
1000126	Syslog - Blue Coat ProxyAV ISA W3C Format
1000127	Flat File - OpenVMS
1000128	UDLA - Metavante Prime Compliance Suite
1000129	Flat File - KERISYS Doors Event Export Format
1000130	Syslog - Cisco Application Control Engine
1000131	Syslog - Enterasys Dragon IDS
1000132	Syslog - Aventail SSL/VPN
1000133	Syslog - Cisco Unified Comm Mgr (Call Mgr)
1000134	Syslog - Palo Alto Firewall
1000135	Syslog - Imperva SecureSphere
1000136	Flat File - Princeton Card Secure
1000137	LogRhythm File Monitor (HP-UX)
1000138	LogRhythm User Activity Monitor (HP-UX)
1000139	Syslog - Linux Audit
1000140	LogRhythm Syslog Server (AIX)
1000141	LogRhythm Syslog Server (Solaris)
1000142	LogRhythm Syslog Server (HP-UX)
1000143	Syslog - Blue Coat ProxyAV MS Proxy 2.0 Format
1000144	Syslog - MacOS X
1000145	Syslog File - HP-UX Host
1000146	LogRhythm SNMP Trap Receiver (Windows)
1000147	Syslog - Juniper DX Application Accelerator
1000148	MS Event Log for XP/2000/2003 - Websphere
1000149	SNMP Trap - Autoregistered
1000150	Flat File - Microsoft IIS FTP IIS Log File Format
1000151	Flat File - Defender Server
1000152	Flat File - HP-UX Audit Log
1000153	Syslog - Nortel Contivity
1000154	Flat File - Linux Audit ASCII
1000155	Syslog - Juniper WX Application Accelerator
1000156	Syslog - Riverbed
1000157	Syslog - Forescout CounterACT NAC
1000158	LogRhythm Process Monitor (Windows)
1000159	LogRhythm Process Monitor (AIX)
1000160	LogRhythm Process Monitor (HP-UX)
1000161	LogRhythm Process Monitor (Solaris)
1000162	LogRhythm Network Connection Monitor (Windows)
1000163	LogRhythm Network Connection Monitor (AIX)
1000164	LogRhythm Network Connection Monitor (HP-UX)
1000165	LogRhythm Network Connection Monitor (Linux)
1000166	LogRhythm Network Connection Monitor (Solaris)
1000167	LogRhythm Process Monitor (Linux)
1000168	Flat File - MS IAS/RAS Server Standard Log Format
1000169	Flat File - IBM Informix Application Log
1000170	Flat File - IBM Informix Audit Log
1000171	UDLA - Oracle 11g Audit Trail
1000172	Flat File - Microsoft SQL Server 2005 Error Log
1000173	MS Event Log for XP/2000/2003 - SCE
1000174	Netflow - Cisco Netflow Version 9
1000175	UDLA - McAfee ePolicy Orchestrator 4.5 - ePOEvents
1000176	Flat File - PureMessage For UNIX Blocklist Log
1000177	Flat File - PureMessage For UNIX Message Log
1000178	UDLA - Finacle Treasury Logs
1000179	Flat File - IBM WebSphere App Server v7 Audit Log
1000180	Flat File - PureMessage For Exchange SMTP Log
1000181	Flat File - Microsoft SQL Server 2008 Error Log
1000182	LogRhythm Demo File - FTP Log
1000183	LogRhythm Demo File - Network Server Log
1000184	LogRhythm Demo File - File Server Log
1000185	LogRhythm Demo File - Mail Server Log
1000186	LogRhythm Demo File - Application Server Log
1000187	LogRhythm Demo File - Web Access Log
1000188	LogRhythm Demo File - IDS Alarms Log
1000189	LogRhythm Demo File - Firewall Log
1000190	LogRhythm Demo File - Content Inspection Log
1000191	LogRhythm Demo File - Database Audit Log
1000192	LogRhythm Demo File - Network Device Log
1000193	LogRhythm Demo File - Netflow Log
1000194	LogRhythm Demo File - Ecom Server Log
1000195	LogRhythm Demo File - VPN Log
1000196	UDLA - Finacle Core
1000197	Syslog - Xirrus Wireless Array
1000198	Syslog - NuSecure Gateway
1000199	Syslog - Fortinet FortiGate v4.0
1000200	Syslog - APC UPS
1000201	Syslog - Cisco Clean Access (CCA) Appliance
1000202	LogRhythm SQL Server 2000 C2 Audit Log
1000203	LogRhythm SQL Server 2005 C2 Audit Log
1000204	LogRhythm SQL Server 2008 C2 Audit Log
1000205	Syslog - Nortel IP 1220
1000206	Syslog - Cisco Secure ACS 5
1000207	Flat File - Cisco LMS (Syslog)
1000208	UDLA - SharePoint 2007 AuditData
1000209	UDLA - SharePoint 2007 EventData
1000210	Syslog - Vormetric CoreGuard
1000211	Flat File - MS Exchange 2010 Message Tracking Log
1000212	Flat File - Cisco LMS (cwcli)
1000213	Syslog - Townsend Alliance LogAgent
1000214	Flat File - Coyote Point Equalizer
1000215	Syslog - Bit9 Parity Suite
1000216	Flat File - F5 BIG-IP ASM
1000217	Syslog - Azul Java Appliance
1000218	Syslog - OSSEC Alerts
1000219	Flat File - Trend Micro IMSS
1000220	Flat File - Nessus System Log
1000221	Flat File - Sharepoint ULS
1000222	Syslog File - Oracle 11g Audit Trail
1000223	Syslog - Oracle 11g Audit Trail
1000224	Flat File - Cisco Web Security aclog
1000225	Syslog - Cisco Nexus Switch
1000226	Flat File - RSA Authentication Manager 6.1
1000227	Flat File - Oracle 11g Fine Grained Audit Trail
1000228	Syslog - Mirapoint
1000229	UDLA - Siemens Invision
1000230	Syslog - Arris CMTS
1000231	Flat File - GlobalSCAPE EFT
1000232	API - Qualys Vulnerability Scanner
1000233	Syslog - RSA Authentication Manager v7.1
1000234	Syslog - Entrust IdentityGuard
1000235	LogRhythm sFlow Server (Windows)
1000236	Syslog - F5 BIG-IP ASM
1000237	API - Nessus Vulnerability Scanner
1000238	API - NetApp CIFS Security Audit Event Log
1000239	sFlow - Version 5
1000240	SNMP Trap - CyberArk
1000241	Syslog - Radware DefensePro
1000242	Syslog - Juniper NSM
1000243	Syslog - H3C Router
1000244	Flat File - Trend Micro Office Scan
1000245	Syslog - Radware Alteon Load Balancer
1000246	Syslog - SEL 3620 Ethernet Security Gateway
1000247	Flat File - MySQL
1000248	SNMP Trap - RSA Authentication Manager
1000249	Syslog - SecureTrack
1000250	Syslog - Squid Proxy
1000251	MS Windows Event Logging - Hyper-V VMMS
1000252	Flat File - MySQL error.log
1000253	Flat File - MySQL mysql-slow.log
1000254	Syslog - Apache Error Log
1000255	Syslog - Apache Access Log
1000256	Flat File - MySQL mysql.log
1000257	Syslog - Citrix XenServer
1000258	SNMP Trap - IBM TS3000 Series Tape Drive
1000259	SNMP Trap - Audiolog
1000260	Syslog - CiscoWorks
1000261	Flat File - Juniper Steel Belted Radius Server
1000262	MS Windows Event Logging - Hyper-V Worker
1000263	MS Windows Event Logging - Hyper-V IMS
1000264	MS Windows Event Logging - Hyper-V Hvisor
1000265	MS Windows Event Logging - Hyper-V Network
1000266	MS Windows Event Logging - Hyper-V SynthSt
1000267	Syslog - IceWarp Server
1000268	Syslog - A10 Networks AX1000 Load Balancer
1000269	Flat File - FairWarning Ready-For-Healthcare
1000270	UDLA - Symmetry Access Control
1000271	MS Windows Event Logging - TS Local Session Manager
1000272	MS Windows Event Logging - TS Licensing
1000273	Syslog - SEL 3610 Port Switch
1000274	Flat File - Microsoft Port Reporter PR-PORTS Log
1000275	Flat File - XPIENT POS POSLOG
1000276	Flat File - Microsoft Windows 2008 DNS
1000277	Flat File - Oracle SunOne Web Server Access Log
1000278	Flat File - Oracle SunOne Directory Server
1000279	Syslog - Raritan KVM
1000280	MS Windows Event Logging - Diagnosis-PLA
1000281	MS Windows Event Logging - Setup
1000282	Syslog - Ecessa ShieldLink
1000283	Flat File - RSA Adaptive Authentication
1000284	Syslog - Adtran Switch
1000285	UDLA - SEL 3530 RTAC
1000286	UDLA - Deepnet DualShield
1000287	Flat File - XPIENT POS Shell Log
1000288	Flat File - Monetra
1000289	Syslog - CoyotePoint Equalizer
1000290	Flat File - DB2 via BMC Log Master
1000291	Syslog - StoneGate Firewall
1000292	J-Flow - Juniper J-Flow Version 5
1000293	J-Flow - Juniper J-Flow Version 9
1000294	Flat File - Postfix
1000295	Syslog File - IRIX Host
1000296	API - NeXpose Vulnerability Scanner
1000297	API - Metasploit Penetration Scanner
1000298	API - Sourcefire eStreamer
1000299	API - BeyondTrust Retina Vulnerability Management
1000300	MS Windows Event Logging - TS Remote Connection Manager
1000301	MS Windows Event Logging - Group Policy Operational
1000302	MS Windows Event Logging - Firewall With Advanced Security
1000303	MS Windows Event Logging - Dot Defender
1000304	OPSEC LEA - Checkpoint Firewall Audit Log
1000305	Syslog - OpenLDAP
1000306	Flat File - Tandem XYGATE
1000307	Flat File - Novell LDAP
1000308	MS Windows Event Logging - Task Scheduler
1000309	MS Windows Event Logging - TS Session Broker Client
1000310	Flat File - FireEye Web MPS
1000311	Flat File - OpenVPN
1000312	Flat File - Merak
1000313	Syslog - Motorola Access Point
1000314	UDLA - LogRhythm Enterprise Monitoring Solution
1000315	Flat File - Oracle Virtual Directory
1000316	Flat File - IT-CUBE AgileSI
1000317	Syslog - ExtremeXOS
1000318	Syslog - ExtremeWare
1000319	Syslog - Nagios
1000320	MS Windows Event Logging - TS Session Broker
1000321	Syslog - Forcepoint DLP
1000322	SNMP Trap - Dell OpenManage
1000323	Flat File - Microsoft IIS Error Log V6
1000324	Syslog - Dell Remote Access Controller
1000325	Syslog - CyberArk
1000326	Syslog - Guardium Database Activity Monitor
1000327	SNMP Trap - Cisco Router-Switch
1000328	Syslog - Quest Defender
1000329	Syslog - 3Com Switch
1000330	Syslog - Trend Micro IWSVA
1000331	Syslog - Snare Windows 2008 Event Log
1000332	Syslog - JetNexus Load Balancer
1000333	Syslog - Cisco WAAS
1000334	Syslog - Trend Micro TDA
1000335	Syslog - F5 Big-IP LTM
1000336	Syslog - Sophos Email Encryption Appliance
1000337	Flat File - Airwatch MDM
1000338	MS Windows Event Logging - MSExchange Management
1000339	Syslog - Tipping Point SSL Reverse Proxy
1000340	Syslog - Sourcefire RNA
1000341	MS Windows Event Logging - Backup
1000342	Syslog - Barracuda Web Application Firewall
1000343	Syslog - Juniper Trapeze
1000344	Syslog - Radware Web Server Director Audit Log
1000345	Flat File - CA ControlMinder
1000346	Flat File - Oracle Listener Audit Trail
1000347	Syslog - Bomgar
1000348	Syslog - APC NetBotz Environmental Monitoring
1000349	Flat File - RL Patient Feedback
1000350	Syslog - HP Virtual Connect Switch
1000351	Flat File - ShoreTel VOIP
1000352	MS Windows Event Logging - Forefront AV
1000353	Syslog - Lieberman Enterprise Random Password Manager
1000354	MS Event Log for XP/2000/2003 - Micros POS
1000355	Flat File - ColdFusion Server Log
1000356	MS Windows Event Logging - Print Services
1000357	Flat File - ColdFusion Application Log
1000358	Syslog - Fargo HDP Card Printer and Encoder
1000359	Syslog - FireEye Web MPS/CMS/ETP/HX
1000360	Flat File - ColdFusion Mailsent Log
1000361	Flat File - ColdFusion Mail Log
1000362	Syslog - Polycom
1000363	Flat File - ObserveIT Enterprise
1000364	Syslog - IPTables
1000365	Syslog - Untangle
1000366	Syslog - eSafe Email Security
1000367	Flat File - Radmin
1000368	Flat File - Voltage Securemail
1000369	Syslog - Cisco ISE
1000370	Syslog - Barracuda Load Balancer
1000371	Flat File - CA ACF2 for z/OS - ACFRPTOM
1000372	Flat File - Axway SFTP
1000373	Flat File - Sudo.Log
1000374	Flat File - Cornerstone Managed File Transfer
1000375	Syslog - Forcepoint Web Security
1000376	Syslog - Checkpoint Site-to-Site VPN
1000377	SNMP Trap - HP Network Node Manager
1000378	UDLA - VMWare vCenter Server
1000379	Flat File - CA ACF2 for z/OS - ACFRPTDS
1000380	Flat File - CA ACF2 for z/OS - ACFRPTPW
1000381	Flat File - CA ACF2 for z/OS - ACFRPTRV
1000382	Flat File - CA ACF2 for z/OS - ACFRPTRL
1000383	Flat File - CA ACF2 for z/OS - ACFRPTNV
1000384	Flat File - CA ACF2 for z/OS - ACFRPTLL
1000385	Flat File - CA ACF2 for z/OS - ACFRPTJL
1000386	Flat File - CA ACF2 for z/OS - ACFRPTEL
1000387	Syslog - Symantec PGP Gateway
1000388	Syslog - Trend Micro Deep Security
1000389	Flat File - IBM WebSphere Cast Iron Cloud Integration
1000390	Syslog - Cisco Web Security
1000391	Syslog - Cisco UCS
1000392	Syslog - Blue Coat PacketShaper
1000393	Syslog - Lancope StealthWatch
1000394	Syslog - Cisco Wireless Access Point
1000395	Flat File - ColdFusion Exception Log
1000396	Syslog - Avocent Cyclades Terminal Server
1000397	Flat File - Microsoft IIS SMTP W3C Format
1000398	Syslog - Hitachi Universal Storage Platform
1000399	Syslog - Sophos Web Proxy
1000400	Syslog - APC ATS
1000401	Syslog - IBM Blade Center
1000402	Flat File - Microsoft Forefront TMG
1000403	Syslog - Citrix Access Gateway Server
1000404	Flat File - Microsoft ActiveSync 2010
1000405	SNMP Trap - Swift Alliance
1000406	Flat File - NetWrix Password Manager
1000407	Syslog - Cell Relay
1000408	Syslog - LOGbinder SP
1000409	Syslog - SnapGear Firewall
1000410	Syslog - Arista Switch
1000411	Syslog - ZXT Load Balancer
1000412	Syslog - Kemp Load Balancer
1000413	SNMP Trap - Trend Micro Control Manager
1000414	Syslog - Outpost24
1000415	UDLA - SharePoint 2010 EventData
1000416	Syslog - APC PDU
1000417	Flat File - Cerberus FTP Server
1000418	Syslog - Apache Tomcat Service Clients Log
1000419	MS Windows Event Logging - SafeWord 2008
1000420	Syslog - Cb Protection CEF
1000421	MS Windows Event Logging - Operations Manager
1000422	Flat File - Cerner
1000423	Syslog - Dell Force 10
1000424	Flat File - DocWorks
1000425	Syslog - Alcatel-Lucent Wireless Controller
1000426	Syslog - Fortinet FortiGate v5.0
1000427	Syslog - Layer 7 SecureSpan SOA Gateway
1000428	Syslog - Raz-Lee
1000429	Flat File - Novell GroupWise
1000430	Syslog - nCircle Configuration Compliance Manager
1000431	Syslog - Corero IPS
1000432	Syslog - EMC VNX
1000433	Flat File - MS Exchange RPC Client Access
1000434	Syslog - Checkpoint Firewall
1000435	Syslog - Smoothwall Firewall
1000436	Netflow - SonicWALL Version 5
1000437	Netflow - SonicWALL Version 9
1000438	Syslog - Bluecat Adonis
1000439	Syslog - HP BladeSystem
1000440	Flat File - Citrix Secure Gateway
1000441	Syslog - IBM WebSphere DataPower Integration
1000442	Syslog - Barracuda NG Firewall
1000443	Syslog - SecureAuth IdP
1000444	Syslog - HP Switch
1000445	Syslog - Certes Networks CEP
1000446	MS Windows Event Logging - Exchange Mailbox DB Failures
1000447	MS Windows Event Logging - FailoverClustering/Operational
1000448	Syslog - Juniper vGW Virtual Gateway
1000449	Syslog - QLogic Infiniband Switch
1000450	Flat File - Symitar Episys Sysevent Log
1000451	Syslog - Blue Socket Wireless Controller
1000452	Syslog - Forcepoint Web Security CEF Format
1000453	UDLA - McAfee Network Security Manager
1000454	Flat File - IBM Tivoli Storage Manager
1000455	Flat File - OpenDJ
1000456	Flat File - Vyatta Firewall Kernel Log
1000457	Flat File - Hadoop
1000458	Syslog - Vamsoft ORF
1000459	Syslog - Avaya Communications Manager
1000460	Syslog - Sentinel IPS
1000461	Syslog - Microsoft Forefront UAG
1000462	Syslog - Entrust Entelligence Messaging Server
1000463	Syslog - Spectracom Network Time Server
1000464	Syslog - Arbor Pravail APS
1000465	Flat File - Apache Tomcat Console Log
1000466	Flat File - Symitar Episys Console Log
1000467	Syslog - Aerohive Access Point
1000468	MS Windows Event Logging : Français - System
1000469	MS Windows Event Logging :Français - Security
1000470	MS Windows Event Logging : Deutsch - Security
1000471	Flat File - Oracle WebLogic 11g Access Log
1000472	Syslog - Siemens Scalance X300
1000473	Syslog - Siemens Scalance X400
1000474	Flat File - Avaya Secure Access Link Remote Access Log
1000475	LogRhythm SQL Server 2012 C2 Audit Log
1000476	Flat File - Tectia SSH Server
1000477	Syslog - Arbor Networks Peakflow
1000478	Flat File - Audit.Log
1000479	Flat File - Microsoft SQL Server 2012 Error Log
1000480	Syslog - Stonesoft IPS
1000481	Syslog - Netscout nGenius InfiniStream
1000482	Syslog - Avaya Ethernet Routing Switch
1000483	MS Windows Event Logging - Digital Persona
1000484	IPFIX - IP Flow Information Export
1000485	Syslog - NETASQ Firewall
1000486	Syslog - Vormetric Data Security Manager
1000487	Syslog - VMWare vShield
1000488	MS Event Log for XP/2000/2003 - EMC Celerra NAS
1000489	Syslog - Mandiant MIR
1000490	Syslog - EMC Centera
1000491	Syslog - Apcon Network Monitor
1000492	Syslog - Barracuda Mail Archiver
1000493	Syslog - Fortinet FortiWeb
1000494	Flat File - ActivIdentity CMS
1000495	MS Windows Event Logging - Kaspersky
1000496	UDLA - Drupal
1000497	Syslog - MobileIron
1000498	Syslog - RADiFlow 3180 Switch
1000499	Syslog - Trustwave Secure Web Gateway
1000500	Syslog - Cisco Prime Infrastructure
1000501	Flat File - Forescout CounterACT
1000502	Syslog - Aruba Clear Pass
1000503	Syslog - Vasco Digipass Identikey Server
1000504	Syslog - D-Link Switch
1000505	UDLA - Symantec CSP
1000506	Flat File - Microsoft Windows 2003 DNS
1000507	Flat File - Linux Host Secure Log
1000508	SNMP Trap - Riverbed SteelCentral NetShark
1000509	Syslog - Blue Coat Forward Proxy
1000510	Syslog - AS/400 via Townsend
1000511	Syslog - IBM Virtual Tape Library Server
1000512	Syslog - RSA Web Threat Detection
1000513	Syslog - Bromium vSentry CEF
1000514	Flat File - Oracle BRM DM Log
1000515	Flat File - Oracle BRM CM Log
1000516	Flat File - Subversion
1000517	Flat File - FundsXpress
1000518	Flat File - Beacon Endpoint Profiler
1000519	Syslog - Thycotic Secret Server
1000520	UDLA - Symantec SEP
1000521	Syslog - IBM Security Network Protection
1000522	Flat File - Kippo Honeypot
1000523	Flat File - PhpMyAdmin Honeypot
1000524	Flat File - WordPot Honeypot
1000525	Syslog - Array TMX Load Balancer
1000526	MS Windows Event Logging - Citrix Delivery Services
1000527	Syslog - NetGate Router
1000528	Flat File - PowerBroker Servers
1000529	Syslog - Aruba Wireless Access Point
1000530	Syslog - Cisco Meraki
1000531	UDLA - McAfee ePolicy Orchestrator 5.0 - ePOEvents
1000532	MS Windows Event Logging - TS Gateway
1000533	Syslog - LOGbinder EX
1000534	Syslog - Tenable Security Center
1000535	Flat File - MicroStrategy
1000536	Syslog - Fortinet FortiMail
1000537	MS Windows Event Logging - DHCP Operational
1000538	UDLA - VMWare vCloud
1000539	LogRhythm Registry Integrity Monitor
1000540	MS Windows Event Logging - DHCP Admin
1000541	Syslog - Huawei Access Router
1000542	Syslog - FireEye E-Mail MPS
1000543	Syslog - Voltage Securemail
1000544	Syslog - Varonis DatAlert
1000545	SNMP Trap - Cisco 5508 Wireless Controller
1000546	Syslog - Zscaler Nano Streaming Service
1000547	Syslog - RedSeal
1000548	UDLA - LREnhancedAudit
1000549	Syslog - EMC Isilon
1000550	UDLA - McAfee ePolicy Orchestrator 5.1 - ePOEvents
1000551	Syslog - EMC Data Domain
1000552	Flat File - McAfee ePO HIPS
1000553	Syslog - Bradford Networks NAC
1000554	Syslog - Dell SecureWorks iSensor IPS
1000555	Syslog - LOGbinder SQL
1000556	Syslog - EMC Avamar
1000557	MS Windows Event Logging - AppLockerApp
1000558	MS Windows Event Logging - Sysmon
1000559	MS Windows Event Logging - Kernel PnP Configuration
1000560	Syslog - Fortinet FortiAnalyzer
1000561	Flat File - MS Exchange 2013 Message Tracking Log
1000562	MS Windows Event Logging XML - Application
1000563	Flat File - EMC Isilon
1000564	Flat File - FileZilla System Log
1000565	MS Windows Event Logging : Español - Security
1000566	MS Windows Event Logging : Español - Application
1000567	Syslog - Fortinet FortiGate v5.2
1000568	MS Windows Event Logging : Español - System
1000569	MS Event Log for XP/2000/2003 - Security - Español
1000570	MS Event Log for XP/2000/2003 - System - Español
1000571	MS Event Log for XP/2000/2003 - Application - Español
1000572	SNMP Trap - Cisco IP SLA
1000573	Syslog - IPSWITCH MOVEit Server
1000574	Syslog - RSA Web Threat Detection 5.1
1000575	API - AWS S3 Server Access Event
1000576	UDLA - Other
1000577	MS Windows Event Logging - Quest ActiveRoles EDM Server
1000578	MS Windows Event Logging - VisualSVN
1000579	Flat File - Microsoft Netlogon
1000580	Syslog - Trend Micro Deep Discovery Inspector
1000581	Syslog - Avaya Router
1000582	Flat File - Microsoft Semantic Logging
1000583	MS Windows Event Logging - ESD Data Flow Track
1000584	Syslog - Nginx Web Log
1000585	Syslog - Adallom
1000586	Flat File - Microsoft Forefront TMG Web Proxy
1000587	UDLA - Microsoft System Center 2012 Endpoint Protection
1000588	Syslog - Sycamore Networks DNX-88
1000589	API - IP360 Vulnerability Scanner
1000590	Syslog - IBM zSecure Alert for ACF2 2.1.0
1000591	Syslog - Forcepoint Email Security Gateway
1000592	Syslog - NetMotion VPN
1000593	Flat File - NetApp Cluster
1000594	Syslog - AirWatch MDM
1000595	Syslog - Cisco FireSIGHT
1000596	Syslog - Trustwave NAC
1000597	Syslog - BitDefender
1000598	API - AWS CloudTrail
1000599	SNMP Trap - Brocade Switch
1000600	API - Cradlepoint ECM
1000601	Syslog - Juniper Firewall 3400
1000602	Flat File - Symantec Antivirus 12.x Corporate Edtn
1000603	Syslog - VMware Horizon View
1000604	Flat File - Alfresco
1000605	UDLA - ObserveIT
1000606	UDLA - SharePoint 2013 EventData
1000607	API - AWS CloudWatch Alarm
1000608	Syslog - Lumension
1000609	API - Salesforce EventLogFile
1000610	API - AWS Config Event
1000611	Flat File - Bro IDS Critical Stack Intel Log
1000612	Syslog - McAfee Web Gateway
1000613	Syslog - Barracuda NG Firewall 6.x
1000614	Flat File - HMC
1000615	Flat File - Cisco Email Security Appliance
1000616	Syslog - HP iLO
1000617	Syslog - McAfee Advanced Threat Defense
1000618	API - Okta Event
1000619	Flat File - Microsoft Windows 2012 DNS
1000620	Syslog - Bit9+Carbon Black (Deprecated)
1000621	Syslog - Bind DNS
1000622	Syslog - Bit9 Security Platform CEF
1000623	Flat File - LOGbinder EX
1000624	API - Nessus Cloud Scanner
1000625	Syslog - CylancePROTECT
1000626	Syslog - Invincea (LEEF)
1000627	MS Windows Event Logging - PowerShell
1000628	MS Windows Event Logging - Lync Server
1000629	SNMP Trap - Cisco Prime
1000630	Flat File - S2 Badge Reader
1000631	Syslog - PingFederate 7.2
1000632	Syslog - PhishMe Triage
1000633	API - Box Event
1000634	Flat File - Avaya Secure Access Link Remote Audit Log
1000635	Syslog - AIMIA Tomcat
1000636	UDLA - CA Single Sign-On
1000637	Flat File - Microsoft SQL Server 2014 Error Log
1000638	Flat File - McAfee SaaS Web Protection
1000639	MS Windows Event Logging XML - Security
1000640	Syslog - Sailpoint
1000641	Syslog - Other 3
1000642	VLS - Syslog - Infoblox - Threat Protection
1000643	VLS - Syslog - Infoblox - DNS RPZ
1000644	Syslog - Skyhigh for Shadow IT
1000645	API - Office 365 Management Activity
1000646	VLS - API - Office 365 Exchange
1000647	VLS - API - Office 365 SharePoint
1000648	Flat File - LogRhythm Data Indexer Monitor
1000649	Syslog - Other 2
1000650	Syslog - Stormshield Network Security Firewall
1000651	Syslog - Cb Response LEEF
1000652	Syslog - CyberArk Privileged Threat Analytics
1000653	Syslog - LogRhythm Data Indexer Monitor
1000654	Syslog - Zix E-mail Encryption
1000655	Flat File - Microsoft IIS 7.x W3C Extended Format
1000656	Syslog - RSA Authentication Manager v8.1
1000657	Syslog - Cisco Telepresence Video Communications Server
1000658	UDLA - Oracle 12C Unified Auditing
1000659	Syslog - CloudLock
1000660	Syslog - Forcepoint SureView Insider Threat
1000661	MS Windows Event Logging - ADFS Admin
1000662	MS Windows Event Logging XML - System
1000663	API - Tenable Security Center
1000664	LogRhythm SQL Server 2014 C2 Audit Log
1000665	Syslog - Accellion Secure File Transfer Application
1000666	Syslog - ZyWALL VPN Firewall
1000667	Syslog - Egnyte
1000668	Syslog - Epic Hyperspace CEF
1000669	Syslog - MS Windows Event Logging XML - Security
1000670	Syslog Avaya G450 Media Gateway
1000671	Syslog - MS Windows Event Logging XML - System
1000672	Syslog - KFSensor Honeypot
1000673	Syslog – Temporary LST
1000674	Syslog - Tanium
1000675	Syslog - Forcepoint Stonesoft NGFW
1000676	Syslog - F5 BIG-IP Access Policy Manager
1000677	Syslog - Aerohive Firewall
1000678	LogRhythm CloudAI
1000679	Syslog - Asus WRT Router
1000680	Syslog - Avaya G450 Media Gateway
1000681	MS Windows Event Logging XML - Unisys Stealth
1000682	Syslog - Crowdstrike Falconhost CEF
1000683	Syslog - Cisco FirePOWER
1000684	Syslog - Tufin
1000685	Flat File - McAfee Web Gateway Audit Log
1000686	Syslog - Temporary LST
1000687	Flat File - Tufin
1000688	Flat File - FoxT BoKS Server Access Control
1000689	Syslog - Splunk API - Checkpoint Firewall
1000690	Syslog - Splunk API - AWS Cloudtrail
1000691	Syslog - KFSensor Honeypot CEF
1000692	Syslog - Splunk API - Nessus Vulnerability Scanner
1000693	Syslog - Imprivata OneSign SSO
1000694	Syslog - Vanguard Active Alerts
1000695	LogRhythm Filter
1000696	UDLA - McAfee ePolicy Orchestrator 5.3 - ePOEvents
1000697	Syslog - Splunk API - Cisco Netflow V9
1000698	Syslog - Lancope StealthWatch CEF
1000699	Syslog - Temporary LST
1000700	Syslog - Fortinet FortiGate v5.4
1000701	MS Windows Event Logging - Citrix XenApp
1000702	Syslog - Cb Defense CEF
1000703	API - AWS S3 Flat File
1000704	Syslog - Sauce Labs
1000705	Flat File - Cisco Umbrella
1000706	Flat File - Forcepoint Web Security CEF Cloud Format
1000707	Syslog - Microsoft Azure MFA
1000708	Syslog - Arbor Networks Spectrum
1000709	Syslog - F5 BIG-IP ASM v12
1000710	Syslog - DarkTrace CEF
1000711	Syslog - mGuard Firewall
1000712	Syslog - SentinelOne CEF
1000713	Syslog - SecureAuth IdP v9
1000714	Flat File - Safenet
1000715	Flat File - LogRhythm Zeus Log
1000716	Flat File - LogRhythm Oracle Log
1000717	Flat File - LogRhythm Trebek Log
1000718	Flat File - Nginx Log
1000719	Syslog - Sguil
1000720	Flat File - Office 365 Message Tracking
1000721	Flat File - Mimecast
1000722	Syslog - Fortinet FortiGate v5.6

/******
SELECT [MsgSourceTypeID],[Name]
  FROM [LogRhythmEMDB].[dbo].[MsgSourceType]
  WHERE RecordStatus = 1 
  AND MsgSourceTypeID <= 999999999 
  AND MsgSourceTypeID >= 2
******/
###>