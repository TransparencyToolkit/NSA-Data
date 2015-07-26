SECRET//REL TO USA, FVEY

5.	(U//FOUO) Perform the following commands only after making changes \n xks.config. At the

command prompt, type:

a.	xks setup plugins : This ensures any applicable changes to plugin configurations
will take effect.

b.	xks rsync push_config : This pushes the latest configuration files to the slaves in
the cluster.

c.	xks proc saferestart : After setup is complete, this restarts
process_data_parent/ s for the new configuration to take effect. This process loads
all the dictionaries and fingerprints and then performs dictionary scanning, metadata
extraction, databasing of metadata, and archival of content. When the parent is finished
reloading, it will do a staggered restart of its children based on which slave the parent is
running on.

(U//FOUO) Using Socket to Send NOFORN Tips to TRAFFICTHIEF

(U//FOUO) Follow these steps to configure the xks.config file use Socket to send NOFORN Tips to
TRAFFICTHIEF:

1.	(U//FOUO) Log onastheuseroper.

2.	(U//FOUO) At the command line from within any directory, type vi config and then press
Enter. The xks.config file will open.

3.	(U//FOUO) In the Inputs section of xks.config, set the following configurations:

a.	alert_output = true: This turns tipping "on."

b.	alert_output_type = so eke t : This indicates that output will be sent via secure
socket.

c.	alert_instance = sitename : This is the location where the tip came from. The
sitename is retrieved from the actual XML of the tip that is generated.

d.	alert_host = 7.216.26.2:443 : This is the IP address and port number where
the alerts are sent.

Note: (U//FOUO) The instance in the actual alert is filled in with the value assigned to
alert_instance in xks.ccnfig.

4.	(U//FOUO) Type wq! and then press Enter to exit xks. config.

3 I

SECRET//RELTO USA, FVEY