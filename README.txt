The published Snowden documents in machine readable form with some useful metadata.

get-data: Scripts for getting and parsing the data.
docs: All the PDFs of the NSA documents.
extract-lists: Lists of terms extracted from text and tags.

Terms Extracted from Manual Tags:
Document topic
Agency names
Country names
Codewords

Terms Extracted from Text:
SIGADs
Country names
Codewords
Classification level
Countries released to
Handling restrictions

----------------------------------------------------------------------
To setup your own instance with LookingGlass:
1. Setup and start LookingGlass and DocManager instances by following steps
1-5 at https://github.com/TransparencyToolkit/Test-Data/blob/master/getting_started.md.

2. In DocManager/dataspec_files/fields_for_all_sources, delete all the files
(run rm *.json). These are fields that are useful with our other tools but not
needed in this instance.

3. In this directory, run: ruby snowden_index_script.rb.
If DocManager is running somewhere other than localhost:3000, the path for
this may need to be adjusted.

4. In LookingGlass/config/initializers/project_config.rb, change the
PROJECT_CONFIG environment variable to "nsadocs"

