SECRET//REL TO USA, FVEY

(U) UTT Configuration
README

(U) Overview

(S//SI//REL) The Unified Targeting Tool (UTT) makes it possible to transition from today's selector-
centric mode of operation, where each type of selector is entered into a different targeting tool, to a
target-centric system. In this system, selection management is converged and then streamlined and
automated, thereby facilitating analyst operation and collaboration. UTT, a mission critical component
of the TURBULENCE architecture, provides a single point-of-servi ce. Analysts enter all of their targeting
requests for intercept from global network communications as well as private networks that are
resident on or accessible using the global network infrastructure, regardless of the types of selectors or
access capabilities to be employed.

(U) UTT Dataflow

(U//FOUO) The UTT pushes selector targeting information to the Site Selection Distribution Manager
(SSDM). The SSDM manages selector tasking at the field site. The SSDM receives the load/updates that
were pushed from the UTT. It is responsible for any site-specific processing that must be performed
before forwarding the appropriate subset of information to site-local collection systems.

(U//FOUO) Once messages are processed, the SSDM sends selector targeting information via
MAILORDER to front-end collection systems at a field site (e.g., XKEYSCORE). The SSDM receives status
back from these systems indicating whether or not the selector tasking was accepted or rejected and
then returns status to the UTT in the form of load and update responses. The SSDM may also request,
either automatically or manually by a local user, that the UTT send a complete reload of all selectors
targeted for the site. Similarly, the field site's front-end collection systems may also request, either
automatically or manually by a local user, that the SSDM send a complete reload of all selectors targeted
for the site.

H

SECRET//RELTO USA, FVEY