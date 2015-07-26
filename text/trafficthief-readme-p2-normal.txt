SECRET//REL TO USA, FVEY

d.	Enter the SID of your alternate POC and then click Continue. A screen containing
contact information for you and your POC will appear.

e.	Add/Edit the contact information as appropriate and then click Continue to go to the
Data transport service screen.

f.	Click Dataflow request and then click Continue. The Request for New Data Flow
on on Existing Transport System screen will appear.

g.	Enter as much information as you can. In the Data Flow Change Description field,
specifically indicate that the pick-up directory should be:

/export/da ta/xkeyscore/ou tpu ts/mai lor d er

h.	Click Submi t. You will receive a confirmation e-mail indicating the ticket has been
received and more information may be requested before the ticket can be completed.
Overall, the process might take anywhere from a few days to a week to complete.

(U//FOUO) Using Socket to Send 5Ks Tips to TRAFFICTHIEF

(U//FOUO) Follow these steps to configure the xks. con fig file use Socket to send Si’s Tips to
TRAFFICTHIEF:

1.	(U//FOUO) Log on as the useroper.

2.	(U//FOUO) At the command line from within any directory, type vi conf ig and then press
Enter. The xks.config file will open.

3.	(U//FOUO) In the Inputs section of xks.config, set the following configurations:

a.	alert_output ■ true : This turns tipping "on."

b.	alert_output_type = socket : This indicates that all output will be sent via
secure socket.

c.	alert_instance = sitename : This helps the analyst determine where the tip
came from. The sitename name is included in the XML of the actual tip sent to
TRAFFICTHIEF.

d.	alert_host = 7.216.26.130:443 : This is the IP address and port number where
the alerts are sent.

Note: (U/FOUO) Which ever value is set equal to alert_instance is the value that is put
into the instance field of the actual alert.

4.	(U//FOUO) Type wq! and then press Enter to exitxks.config.

2 I

SECRET//RELTO USA, FVEY