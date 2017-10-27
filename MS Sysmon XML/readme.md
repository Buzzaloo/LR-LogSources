# Microsoft Sysmon XML Format

This repository includes custom MPE rules for Microsoft's Sysmon, v6+. The difference from in-built rules available with LogRhythm is that they use the Windows native XML format, more performant, and  makes use of the newer metadata fields available from LogRhythm 7.2.x onwards.

Other customizations include:
*	parsing ProcessGuid into the Session metadata field
*	parsing all parent process information
*	extracting one Hash value, SHA1 from all events
*	parsing of LogonGuid into Group field

While these parsing rules are primarily written for collection over RPC, the regex will match against Sysmon logs sent via Syslog, such as from Splunk or Elastic.

### How to add XML Sysmon Logs?

At present, in order to collect Sysmon logs in XML format you'll need to do the following:
1) Within the LogRhythm Admin Console, browse to Tools > Knowledge > MPE Rule BuilderImport
2) Import each of the  custom MPE rules from  this Github repository
3) Ensure all rules are set to Production status
4) Under the Log Processing Policies tab, create a new Policy called Sysmon, choose "System MS Windows Event Log XML - Security"
5) Filter for custom rules, select the newly imported rules and enable them
6) Finally, add your new "System MS Windows Event Log XML - Security" log sources, with the Event Log path to Sysmon, and choose the MPE Process Policy called Sysmon