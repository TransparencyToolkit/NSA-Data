SECRET//REL TO USA, FVEY

(U) VoIP Configuration
and Forwarding Read Me

(U) Overview

(U//FOUO) In the late 1990s, voice over IP (VoIP) emerged as an alternative to the Time Division
Multiplexed (TDM) technology for transporting international voice traffic. Since then, VoIP has
developed into a widely used technology that accounts for a large percentage of cross-border voice
traffic.

(S//SI//REL) NUCLEON is NSAW's signals intelligence voice, facsimile, video and pre-released
transcription repository. It supports over 8000 users worldwide and is composed of 75 operational
servers receiving 700,000 voice, fax, video, and tag files per day. This Read Me provides procedures for
configuring XKEYSCORE to generate and forward VoIP hits to NUCLEON.

(U) Pre-Configuration Requirements

(C//REL) Before configuring xks.config for VoIP processing you must:

1.	Confirm UTT tasking is in place for the UTT selectors to be used. Please refer to the UTT
Configuration Read Me to ensure UTT tasking has been set up.

2.	Confirm MAILORDER is configured to pick up MAILORDER files from the
$XSCORE_DATA_DIR/outputs/mailorder directory on the Master server. To do this, create a
MAILORDER ticket to set up the pick-up directory for your Master XKS server:

a.	Type go mailorder in the URL field of a browser on a high-side computer.

b.	Click PATHMASTER Remedy Ticket near the top right of the screen. The Remedy
Ticket Submission screen will appear.

c.	In the bottom half of the Remedy Ticket Submission screen is two yellow Submit
Remedy Ticket buttons. Click the top button of the two. (This ticket pertains to New
Data-Flow). The ITSC login screen will appear.

d.	Enter the SID of your alternate POC and then click Continue. A screen containing
contact information for you and your POC will appear.

e.	Add/Edit the contact information as appropriate and then click Continue to go to the
Data transport service screen.

f.	Click Dataflow request and then click Continue. The Request for New Data Flow
on on Existing Transport System screen will appear.

SECRET//REL TO USA, FVEY