SECRET// REI TO USA, FVEY

g. Enter as much infocmation as you can. In the Data Flow Change Description field,
specifically indicate that the pick-up directory should be:

/$XSCO R E_DATA_DI R/outputs/ma il order

h. Click Submi t. You will receive a confirmation e-mail indicating the ticket has been
received and more information may be requested before the ticket can be completed.
Overall, the process might take anywhere from a few days to a week to complete.

(C//REL) Configuring xks.config for VoIP Processing

(U) Configuration for VoIP can be accomplished in just three steps:

1.	(U//FOUO) Log on as the user oper.

2.	(U//FOUO) At the command line from within any directory, type vi conf ig and then press

Enter. The xks.config file will open.

3.	(U//FOUO) In the VoIP Configuration section of xks.config, set the following configurations:

a.	voip - yes : This runs the VoIP workflows.

b.	voip_mode = site : This indicates that normal site VoIP workflows will run. Other
valid values are:

o overlord: runs workflows for the overlord server to do cross-duster pairing at
the same site.

o cross_site: runs workflows for the central VoIP server to do cross-site pairing.

c.	voip_tasking_site_utt = {default :yes} : This uses UTT tasking from the
site SSDM. It assumes you have an SSDM at site that is sending UTT tasking to XKEYSCORE
and that you have "utt = yes" in the xks.config file (see UTT configuration).

d.	voip_tasking_site_csv - {default :no} : This controls where VoIP uses csv
files from. By default, it uses the csv files from $XSCORE_DIR/config/dictionaries/voip_site.

Note: If you are using target number directory (tnd) tasking, then you must change the
setting to yes. Provided tnd=yes in xks.config, the tnd_procpy script will write a csv file
to $XSCO R E_DI R/conf ig/di ct ion ari es/voip_site.

e.	voip_tasking_royale_file = (defaulttno) : This controls whether or not
config/dictionaries/voip/xkdb_tasking.csv is used. This file represents the legacy way of
tasking VoIP, but it is not guaranteed to be completely legal for any site. By default, it is set
not to be used and should only be used as a last option when no site-specific tasking is
available.

21

SECRET// RELTO USA, FVEY