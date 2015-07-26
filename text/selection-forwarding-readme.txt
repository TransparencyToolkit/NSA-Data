UNCLASSIFED//FOR OFFICIAL USE ONLY

(U//FOUO) Forwarding Selected
MAILORDER Files Read Me

(U//FOUO) This document explains how to configure an XKS cluster to forward selected sessions via
MAILORDER. Sessions are still scanned, tagged, and queryable in XKEYSCORE, even if the quota limit
(category throttling) has been exceeded for the day. Use this document to learn the procedures for
switching all Digital Network Intelligence (DNI) filtering and selection to the XKEYSCORE collection
system.

(U//FOUO) Configuring DNI Selection in xks.config

(U//FOUO) Follow these steps to configure xks.config to use the XKS collection system for DNI filtering
and selection:

1.	(U//FOUO) Logon as the user oper.

2.	(U//FOUO) At the command line from within any directory, type viconfig and then press

Enter. The xks.config file will open.

3.	(U//FOUO) In the Inputs section of xks.config set the following configurations:

a.	forward_sessions = yes : This enables session forwarding on the
selected_output plugin. You can verify that session forwarding is set to yes in the
default.xml f\e located in $XSCORE_DIR/conf ig/plugins .

Note: Only after running the xks setup plugins process, described on page 2, will
you see the selected_output plugin enabled in defoult.xml.

b.	category_throttle = true (default). This sets the maximum number of
sessions per category to 10,000 and the total size forwarded for any given category to be no
greater than 1GB. If either of these limits is reached, XKEYSCORE will no longer forward
sessions that hit on that particular category for the rest of the day. It will, however,
continue to process data for other categories. These limits are reset every 24 hours.

c.	All MAILORDER files will be stored on the Master server in:

/export/d ata/xkeyscore/ou tputs/ma il order

1 I

UNCLASSIFED//FOR OFFICIAL USE ONLY

UNCLASSIFIED//FOR OFFICIAL USE ONLY

You can check the status of the category throttle using one of the following commands:

•	mysqls quota_status_current

The quota_limits forwarding status for all categories.

•	mysqls quota_status_yesterday

The quota_limits forwarding status for the previous day.

•	mysqls quota_throttled_current

The top 20 categories for the current day (The phrase "negative remaining"
indicates the category was throttled).

d.	output_location = master : All MAILORDER files will be generated in:

/xks_data/<masterHostname>/outputs/mailorder_working

Then the mailorder_proc process on the Master will rename and move them to:
/xks_data/<masterHostname>/outputs/mailorder

e.	mailorder = yes (default) : On the Master, this creates the
mailorder_proc process that polls the mailorder_working directory and then
moves/renames any MAILORDER files to $XSCORE_DATA_DIR/outputs/mail order.

4.	(U//FOUO) Type :wq! and then press Enter to save and exit xks.config.

(U//FOUO) Additional Processes

(U//FOUO) In addition to editing the configurations in xks.config, it is important to run several set-up
processes.

1.	(U//FOUO) As the oper user, at the command prompt, type xks setup plugins and press
Enter. This ensures any applicable changes to plugin configurations will take effect.

2.	(U//FOUO) As the oper user, at the command prompt, type xks setup processes and
press Enter. This will create the mailorder_proc process on the Master.

3.	(U//FOUO) At the command prompt, type rsync push_config and press Enter. This
pushes the latest configuration changes to the slaves.

4.	(U//FOUO) As the oper user, at the command prompt, type xks proc start and press
Enter . This will ensure all of the running processes pick up any configuration changes.

5.	(U//FOUO) At the command prompt, type xks proc saferestart and press Enter. After
setup is complete, this restarts process_datas for the new configurations to take effect.

2 I

UNCLASSIFIED//FOR OFFICIAL USE ONLY