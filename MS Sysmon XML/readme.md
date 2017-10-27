# Microsoft Sysmon XML Format

This repository includes custom MPE rules for Microsoft's Sysmon, v6+. The difference from the in-built rules available with LogRhythm are that it uses the Windows native XML format, which is more performant, and also makes use of the newer metadata fields available from LogRhythm 7.2.x onwards.

Other customizations include:
*	parsing ProcessGuid into the Session metadata field
*	parsing all parent process information
*	extracting one Hash value, SHA1 from all events
*	parsing of LogonGuid into Group field

While these parsing rules are primarily written for collection over RPC, the regex will match against Sysmon logs sent via Syslog, such as from Splunk or Elastic.

