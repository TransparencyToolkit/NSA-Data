CON Fl DENTIAL//SI

(U/FOUO) CADENCE
Read Me

(U) Overview

(C//SI) CADENCE is a strong selection tasking tool dating back to the days of telegraphy. In the world of
telegraphy, only the textual content of the communications was intercepted. CADENCE'S role was to
assign categories to the text and then forward the data for a given category. CADENCE, in combination
with software selection tools, is still used today by many Digital Network Intelligence (DNI) systems.

(U//FOUO) XKEYSCORE can be configured to ingest CADENCE dictionaries, and provide high-speed
content filtering, selection, and forwarding capabilities.

(C//SI) The CADENCE system fully automates the Front-End Dictionary Management process to filter and
select intelligence. Dictionary managers and target analysts can electronically submit, review, and
forward dictionary updates to scan traffic for keywords, to execute category rules and to define Boolean
and positional equations of keywords. Receipts for these requests are automatically generated, statistics
are compiled and reported, and approved updates are maintained in a database containing historical
information for the DDO review of "USSID-18" compliance.

(U//FOUO) Configuring XKEYSCORE for CADENCE can be accomplished in three steps. First, you must
complete a pre-configuration set-up process. Next you will configure xks.config to enable CADENCE
tasking and appropriate MAILORDER routing. Last, you will execute additional set-up processes:

(U) Pre-Configuration Set-Up

(U//FOUO) Follow these steps before configuring XKEYSCORE for CADENCE:

1.	(U//FOUO) To submit a new Data Management Requirement (DMR), in your browser, go to:

3ml/s3ml4/s3ml41/index.php?content=dataManagement

and follow steps 1-3 for submitting a new DMR.

1 |

CON FI DENTI AL//SI

CON Fl DENTIAL//SI

2.	(U//FOUO) Create a MAILORDER ticket to set-up the pick-up directory for your Master
XKEYSCORE server:

a.	Type go mailorder in the URL field of a browser on a high-side computer.

b.	Click on the yellow PATHMASTER Remedy Ticket button near the top right of
the screen. The Remedy Ticket Submission screen will appear. In the bottom half of the
screen are two regions each containing a yellow Submi t Remedy Ticket button.

c.	In the bottom half of the Remedy Ticket Submission screen is two yellow Submit
Remedy Ticket buttons. Click the top button of the two. (This ticket pertains to New
Data-Flow). The ITSC login screen will appear.

d.	Enter the SID of your alternate POCand then click Continue. A screen containing
contact information for you and your POC will appear.

e.	Add/Edit the contact information as appropriate and then click Continue to go to the
Data transport service screen.

f.	Click Dataf low request and then click Continue. The Request for New Data Flow
on an Existing Transport System screen will appear.

g.	Enter as much information as you can. In the Data Flow Change Description field,
specifically indicate that the drop-off directory should be:

/export/data/xkeyscore/inputs/mailorder

h.	Click Submi t. You will receive a confirmation e-mail indicating the ticket has been
received, and more information may be requested before the ticket can be completed.
The overall process might take anywhere from a few days to a week to complete.

3.	Repeat step 2 to create a MAILORDER ticket to set-up the pick-up directory for your Master
XKEYSCORE server. In this case, in step g, specifically indicate that the pick-up directory should
be: /export/ data /xkeyscore/outp uts/mai lord er.

4.

(U//FOUO) After you receive an approved response back for your DMR, send an e-mail message

to start receiving CADENCE tasking.

2 | P a g e

CON FI DENTI AL//SI

CON FI DENTIAL//SI

(U//FOUO) Configuring xks.config

1.	(U//FOUO) Log on as the user oper.

2.	(U//FOUO) At the command line from within any directory, type viconfig and then press
Ente r. The xks.config file will open. Set the following four CADENCE configurations:

a.	cadence = yes: This enables CADENCE tasking. The default setting for this
configuration is no. This entry is what creates the cadence_tasking_proc process, after
xks setup processes is run.

Note: If you enable CADENCE, then you must set up MAILORDER inputs for
CADENCE to go into inputs/cadence. (See step 2d below.)

b.	si te_f di = XXX: This is the identifying trigraph assigned to a particular system that is
embedded inside a response message so CADENCE can determine which system sent a
response. The cadence_tasking_proc option uses thisfdi. XXX is the default.

(See Additional Processes, Step 4.)

c.	mailorder = yes: This enables the mailorder_proc process. Its default is no.

d.	mailorde r_input [ 0] = source : 00: TY, di r: cadence

This re-directs all incoming files that have a PDDG of 00 and a source system digraph of
TY from $XSCORE_DATA_DIR /inputs/mailorder to$XSCORE_DATA_DIR/inputs/cadence.

3.	(U//FOUO) In the #[dictionaries] section of xks.config, below the line "dictionary[] =
PLACEHOLDER-DO NOT REMOVE-ADD ENTRIES BELOW", type:

dictionary[0] = type=cadence

(U//FOUO) This setting indicates that all tasking should be pulled locally from
$XSCORE_DATA_DIR/dictionaries/cadence/dicts and.../fists. This will use the fist_li nks file
that was delivered by CADENCE for mapping the dictionary: fis t_table and can be
found in $XKSCORE_DATA_DIR/dictionaries/cadence.

(U//FOUO) When the xks update_dictionaries process runs as a cronjob, then it knows
automatically to pull the updates from these directories.

Note: (U//FOUO ) CADENCE dictionaries must end with .netlayerand fist tables
must end with .fist.

4.	(U//FOUO) Type :wq! and then press Enter to exit xks.config.

3 | P a g e

CON FI DENTI AL//SI

CON FI DENTIAL//SI

Additional Processes

(U//FOUO) After editing CADENCE configurations in xks.config, it is time to run some set-up

processes.

1.	(U//FOUO) At the command prompt, type xks setup processes and press Enter. When
cadence=yes in xks.config, this creates cadence_tasking_p roc. And, if
mailorder=yes, it will also create the check_mailorde r_site . php and
mailorder_proc processes.

2.	(U//FOUO) At the command prompt, type xks proc start and press Enter. This starts
any processes that were created in step 1, cadence_tasking_proc, mailorde r_proc
and check_mailorde r_site . php.

3.	(U//FOUO) If a MAILORDER input rule is changed in xks.config, then type xks proc
restart cms to restart the check_mailorde r_site . php process.

Note: (U//FOUO) The xks update_dictionaries cronjob will run once an hour. It reads the
dictionaries section of the $XSCORE_DIR/config/xks.config file and copies the dictionaries and
fists from $XSCORE_DATA_DIR/dictionaries/cadence/dicts and ../fists to
$XSCORE_DIR/config/dictionaries/cadence. This is where the process_data_parent's (i.e., the
XKS processes that load dictionaries and do the selection, scanning and forwarding) actually load
their dictionaries from.

4 |

CON FI DENTI AL//SI