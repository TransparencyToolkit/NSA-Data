SECRET

(U//FOUO) Atomic SIGINT Data Format (ASDF)

Configuration Read Me

(U) Overview

(U//FOUO) The ASDF Configuration Read Me is designed to provide procedures for other organizations
to configure their own XKEYSCORE servers tailored to their requirements and mission. More specific, it
provides procedures for generating and forwarding ASDF data to FALLOUT, which then is forwarded to
the MARINA repository.

(S) FALLOUT is a DNI metadata exploitation and integrity service which converts, validates, normalizes,
classifies, and distributes DNI metadata according to algorithms and rules produced by Protocol
Exploitation. FALLOUT feeds corporate metadata repositories, such as MARINA, METAWAVE, FASCIA,
and MAINWAY, with full-take and selected metadata derived from collection and processing systems
such as TURMOIL, WEALTHYCLUSTER 2.0, XKEYSCORE, BLACKPEARL, SCISSORS, and others.

(S) The MARINA metadata application tracks a user's browser experience, gathers contact
information/content, and develops summaries of target activity. This tool offers retrieval, data
aggregation, viewing, and some manipulation of specific data types collected worldwide.

(U//FOUO) Configuring XKEYSCORE for ASDF can be accomplished in three phases. First, you will address
two pre-configuration requirements. Next you will configure xks.config for ASDF forwarding. Last, you
will execute a group of set-up processes.

(U) Pre-Configuration Requirements

(U//FOUO) The Atomic SIGINT Data Format (ASDF) requires the following:

The most recent StarProc update on each XKEYSCORE server that is processing data. Please see
the Royale with Cheese Updater How To document to configure your XKEYSCOREto pull the
latest StarProc updates.

MAILORDER configured to pick up KLG MAILORDER files from the Master server in the
$XSCORE_DA TA_DIR/outputs/mailorder directory.

1 | Page

SECRET

SECRET

(U//FOUO) Configuring xks.config to Generate ASDF Files

(U) Configuration for generating and forwarding ASDF can be accomplished in just five steps:

1.	(U) Logon as the user ope r.

2.	(U//FOUO) At the command line from within any directory, typeviconfig and then press
Ente r. The xks.config file will open.

3.	(U//FOUO) In the #outputs section of xks.config, set the following configurations:

a.	asdf_output = yes : This enables the digester plugin.

b.	asdf_trig raph = KLG : This sets the MAILORDER trigraph to correctly write out the
asdf MAILORDER files.

c.	asdf_priority = 2 : This sets the priority in the MAILORDER file name.

4.	(U//FOUO) In the #[processes] section of xks.config, set mailorder = yes to enable
MAILORDER.

5.	(U)Type :wqi and then press Ente r to save and exit xks.config.

(U) Additional Processes

(U) In addition to editing configurations in xks.config, it is important to run several set-up commands.

1.	(U//FOUO) At the command prompt, type xks setup processes and press Ente r.
Because MAILORDER is enabled in step 4above (i.e., mailorder = yes), executing this
command will create the mai lo rde r_proc process on the Master server.

2.	(U//FOUO) At the command prompt, type xks proc start and press Ente r. This will
ensure all of running processes pick up any configuration changes.

3.	(U//FOUO) At the command prompt, type xks setup plugins and press Ente r. Because
The digester plugin is enabled in step 3a above (i.e., asdf_ouput = yes), executing this
command will setupthe digest plugin on the Master server.

4.	(U//FOUO) At the command prompt, type xks rsync push_conf ig and press Ente r. This
pushes the new plugin_config to the slaves, after running the step above.

5.	(U//FOUO) On the Master server, from the command prompt, type xks proc
safe restart to restart the process_data_parent' s.

2 | Page

SECRET