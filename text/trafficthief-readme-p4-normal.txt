SECRET//REL TO USA, FVEY

5.	(U//FOUO) Perform the following commands only after making changes in xks.config. At the

command prompt, type:

a.	xks setup plugins : This enables the alert_traf f icthief plugin with the
configurations established in Step 3 above .

b.	xks rsync push_config : This pushes the latest configurations to the slaves in the
cluster.

c.	xks proc saferestart : After setup is complete, this restarts
process_data_parent/ s for the new configuration to take effect. This process loads
all the dictionaries and fingerprints and then performs dictionary scanning, metadata
extraction, databasing of metadata, and archival of content.

(U//FOUO) Using MAILORDER to Send Si's Tips to TRAFFICTHIEF

(U//FOUO) Follow these steps to configure the xks.config file to use MAILORDER to send Si's Tips to
TRAFFICTHIEF:

1.	(U//FOUO) Log onastheuseroper.

2.	(U//FOUO) At the command line from within any directory, type vi conf ig and then press
Enter. The xks.config file will open.

3.	(U//FOUO) In the Inputs section of xks.config, set the following configurations:

a.	alert_output = true : This turns tipping "on."

b.	alert_output_type = mailorder : This indicates that output will be sent via
MAILORDER.

c.	alert_instance - sitename : This is the location where the tip came from. The
sitename is retrieved from the actual XML of the tip that is generated.

d.	alert_host - : This is the IP address where the alerts are sent. No IP address is
required because, in this case, tips are being sent via MAILORDER.

Note: (U//FOUO) The instance in the actual alert is filled in with the value assigned to

alert_instance in xks.config.

4.	(U//FOUO) Type wq! and then press Enter to exit xks.config.

5.	(U//FOUO) Perform the following commands only after making changes in xks.config. At the
command prompt, type:

a. xks setup plugins : This ensures any applicable changes to plugin configurations
will take effect.

4|

SECRET//RELTO USA, FVEY