SECRET//REL TO USA, FVEY

(U) Additional Processes

(U//FOUO) In addition to editing UTT/SSDM configurations in xks.config and xks.odvanced.config, it is
important to execute several set-up processes. As the oper user, execute the following commands only
after entering the SSDM configurations in xks.config:

1.	(U//FOUO) At the command prompt, type xks setup processes and press Enter. This
creates the check_mailorder_site .php andmailorder_proc processes on the
Master server.

2.	(U//FOUO) At the command prompt, type xks proc start and press Enter. This will
ensure all of the running processes pick up any configuration changes.

As a result of executing these commands, the following processes will begin:

- (U//FOUO) The check_mailorder_site .php process, which polls

$XSCORE_DATA_DIR/input s/ssdm and moves the SSDM MAILORDER file(s) to the
$XSCORE_DATA_DIR/inputs/ssdm directory, according to the [mailorder_input]
rule in the xks.config file.

Note: If a MAILORDER input rule is changed in xks.config, then type xks proc restart
cms to restart the check_mailorder_site .php process.

(U//FOUO) The mailorder_proc process, which polls

$XSCORE_DATA_DIR/outputs/mailorder_working directory and properly renames and moves
any MAILORDER files to $XSCORE_DATA_DIR/outputs/mailorder for pick-up by MAILORDER.

(U//FOUO) The strong_selector_targeting process, which polls$XSCORE_DATA_DIR
/inputs/ssdm for any tasking updates or full loads. When it receives a message from the SSDM
that updates are available, a response receipt is generated and sent to
$XSCORE_DATA_DIR/outputs/mailorder_workir>g. Next, strong_selector_targeting
processes the UTT updates/tasking files and writes the processed files to
$XSCORE_DIR/config/dictionaries/selectors/strong.selectors.

(U//FOUO) Another receipt is generated after processing of an update/full load is complete. The
message indicates success or failure and is also placed into $XSCORE_DATA_DIR
/out put s/mai lorder_wor ki ng.

Note: (U//FOUO) The strong_selector_targeting process will request a reload if it
receives SIGUSR2, if it starts up and seesutt .selectors is still there, or if it starts up
and has no targeting.

51

SECRET//RELTO USA, FVEY