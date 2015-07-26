SECRET//REL TO USA, FVEY

(U//FOUO) TRAFFICTHIEF
Configuration Read Me

(U) Overview

(S//REL) TRAFFICTHIEF (TT) is the NSA corporate alerting and tipping system. Independent collection
systems such as XKEYSCORE provide real-time messages, called events (tips), to the TRAFFICTHIEF
server. TRAFFICTHIEF receives these tips in real-time when targets are actively communicating,
enhances messages with geo-location information and then immediately alerts analysts to this activity.

(U) Pre-Configuration Requirements

(U/FOUO) Before configuring xks.config for TRAFFICTHIEF tipping, you must:

1.	(S//SI//REL) Confirm Unified Targeting Tool (UTT) tasking is delivered from a Site Selection
Distribution Manager (SSDM). Please refer to the UTT Configuration Read Me for configuring
UTT tasking.

2.	(S//SI//REL) Confirm the UTT sends selector targeting information to the SSDM to manage
selector tasking at a field site. The SSDM receives load and update requests from UTT and is
responsible for any site-specific processing that must be performed before forwarding the
appropriate subset of information to the site-local collection system.

3.	(C) Confirm that port 443 is open if tips will be sent via socket to the TT server (e.g., using the
alert_trafficthief plugin).

NOTE: (U//FOUO) If tips will be sent over MAILORDER (i.e., using the alert_mailorder plugin),
then port 443 does not need to be opened.

4.	(C) Confirm MAILORDER is configured to pick up MAILORDER files from the
$XSCORE_DATA_DIR/outputs/mailorder directory on the Master server. To do this, create a
MAILORDER ticket to set up the pick-up directory for your Master XKS server:

a.	Type go mailorder in the URL field of a browser on a high-side computer.

b.	Click PATHMASTER Remedy Ticket near the top right of the screen. The Remedy
Ticket Submission screen will appear.

c.	In the bottom half of the Remedy Ticket Submission screen is two yellow Submit
Remedy Ticket buttons. Click the top button of the two. (This ticket pertains to New
Data-Flow). The ITSC login screen will appear.

1 I

SECRET//RELTO USA, FVEY