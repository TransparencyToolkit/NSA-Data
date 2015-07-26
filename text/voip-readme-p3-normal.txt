SECRET// REI TO USA, FVEY

f.	voip_forward_voice=enable=yes, fdi="FDO", local_fdi="FDl; J: FD2;K: FD3"
This enables forwarding of voice captures. Set the file distribution indicator (fdi) to the
MAILORDER trigraph for voice (FDO). Configure local_fdi if you want to route local zip
codes to a different fdi. Zip codes that begin with 'L' are forwarded to FDI, zip codes that
start with 'J' go to FD2, and zip codes that start with 'K' go to FD3.

g.	voip_forward_fax-enable-yes, fdi-"DEF", local_fdi-"XXX" : This
enables forwarding of captured faxes. The file distribution indicator (fdi) should be set to the
MAILORDER trigraph for faxes. And, set the local_fdi if you want to route local zip codes
that start with 'L' to a different fdi.

h.	voip_forward_dictionaries=,'uttdnr,, : This indicates that VoIP forwarding
dictionaries will use UTT selectors.

i.	csdf_classification = "" : This overrides the default classification of the system.
By default this option is commented out, but it can be uncommented and modified.

(U) Additional Processes

(U//FOUO) In addition to editing VoIP configurations in xksxonfig, it is important to execute several set-
up processes. As the oper user, execute the following commands only after entering the VoIP
configurations in xksxonfig:

1.	(U//FOUO) xks setup voip : This ensures all VoIP configurations are applied where
applicable.

2.	(U//FOUO) xks rsync push_config: This pushes any changes to the slaves in the
duster.

3.	(U//FOUO) xks proc saferestart: After setup is complete, this restarts
process_data_parent ' s for the new configuration to take effect. This process loads all
the dictionaries and fingerprints and then performs dictionary scanning, metadata extraction,
databasing of metadata, and archival of content. When the parent is finished reloading, it will do
a staggered restart of its children based on which slave the parent is running on.

31

SECRET// RELTO USA, FVEY