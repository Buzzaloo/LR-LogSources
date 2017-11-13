# Microsoft Sysmon XML Format

This repository includes custom normalisation (MPE) rules for Microsoft's Sysmon (MS Sysmon), v6+, in the LogRhythm Platform. The difference from in-built ruleset available with LogRhythm is that these rules use the Windows native XML format, which is more performant, and make use of the enhanced 7.2.x schema metadata fields.  Other customizations include:

*	parsing ProcessGuid into the Session metadata field
*	parsing all parent process information into parent process, parent process id, and parent process path fields
*	extracting one Hash value, SHA1 from all events - this is an important Sysmon configuration requirement
*	parsing of LogonGuid into the Group field
*   regex written in a way that makes customization easy is changes are required

While these parsing rules are primarily written for collection over RPC, the regex will match against Sysmon logs sent via Syslog, such as from Splunk or Elastic agents.

### How to add XML Sysmon Logs?

At present, in order to collect Sysmon logs in XML format you'll need to perform the following workaround until such time native XML event log collection can be configured on user defined log sources:
1) Within the LogRhythm Admin Console, browse to Tools > Knowledge > MPE Rule BuilderImport
2) Import each of the  custom MPE rules from  this Github repository
3) Ensure all rules are set to Production status
4) Under the Log Processing Policies tab, create a new Policy called Sysmon, choose "System MS Windows Event Log XML - Security"
5) Filter for custom rules, select the newly imported rules and enable them
6) Finally, add your new "System MS Windows Event Log XML - Security" log sources, with the Event Log path to Sysmon, and choose the MPE Process Policy called Sysmon

### Customizing the normalisation rules
The MPE rules have been written to be readable and easy to change.  While the most useful fields have been attempted to be extracted, there may be scenarios where different use cases require metadata extraction outside of the above.

### MS Sysmon Event IDs
As mentioned, these normalisation rules have been written for use with Microsoft Sysmon version 6:
1	Process Create
2	File creation time
3	Network connection detected
4	Sysmon service state change (cannot be filtered)
5	Process terminated
6	Driver Loaded
7	Image loaded
8	CreateRemoteThread detected
9	RawAccessRead detected
10	Process accessed
11	File created
12	Registry object added or deleted
13	Registry value set
14	Registry object renamed
15	File stream created
16	Sysmon configuration change (cannot be filtered)
17	Named pipe created
18	Named pipe connected

### Filtering with Microsoft Sysmon
MS Sysmon should always be used with a filter and configuration XML file.  The default configuration can be excessively noisy.  The recommended resource to deploy your MS Sysmon configuration off of is from @SwiftOnSecurity, available here - https://github.com/SwiftOnSecurity/sysmon-config

### Misc
Finally, please note these are not official LogRhythm nor LogRhythm Labs MPE rules, and you should use at your own discretion.