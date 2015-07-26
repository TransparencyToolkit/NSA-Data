SECRET//REL TO USA, FVEY

(U/FOUO) Configuring UTT Selection in xks.config

(U//FOUO) Configuration for UTT selection and tasking can be accomplished in just seven steps:

1.	(U//FOUO) Logon as the user oper.

2.	(U//FOUO) At the command line from within any directory, type vi conf ig and then press
Enter. The xks.config file will open.

3.	(U//FOUO) In the [dictionaries] section of xks.config, set the following configurations:

a . utt = yes : This enables UTT tasking. The default setting for this configuration is no.

b. ssdm_trigraph = [field site trigraph] : This is the SSDM's trigraph for
the field site. The default is XXX, which will need to be changed.

4.	(U//FOUO) In the [processes) section of xks.config confirm that the MAILORDER configuration
reads mailorder = yes.Thedefaultisno.Thiscreatesthemailorderjirocprocess.

5.	(U//FOUO) In the Mailorder inputs section of xks.config, typemailorder_input [0] =
source :00: AB, dir: ssdm. This is the input configuration for

check_mailorder_site .php.This particular configuration indicates that all incoming files
in $XSCORE_DATA_DIR/inputs/mailorder that have a Producer Designator Digraph (PDDG) of 00
and a source system digraph of AB will be moved to $XSCORE_DATA_DIR/inputs/ssdm.

6.	(U//FOUO) In the Plugin Config section of xks.config is the following placemark:

forwarding_domain [ ] = PLACEHOLDER - DO NOT REMOVE - ADD ENTRIES BELOW

Below this placemark, type your own forwarding domains (i.e., routing trigraphs) like those
identified in the Forv/arding Domains chart. Forwarding Domains are in the form:

forwarding_domain [N] = key:value, key2 :value2,...

31

SECRET//RELTO USA, FVEY