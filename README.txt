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
1. Setup LookingGlass and DocManager instances by following steps -5 at
https://github.com/TransparencyToolkit/Test-Data/blob/master/getting_started.md.

2. cp setup/version_fields.json to
DocManager/dataspec_files/fields_for_all_sources/version_fields.json
This hides a field that isn't needed for this instance

3. Start DocManager

4. In the setup/ directory, run: ruby snowden_index_script.rb.
If DocManager is running somewhere other than localhost:3000, the path for
this may need to be adjusted.

5. In LookingGlass/config/initializers/project_config.rb, change the
PROJECT_CONFIG environment variable to "nsadocs". Then, start LookingGlass.

