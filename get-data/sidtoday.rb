# coding: utf-8
require 'open-uri'
require 'nokogiri'
require 'json'
require 'selenium-webdriver'
require 'american_date'
require 'pry'
require 'headless'

class Sidtoday
  def initialize
    @page = open("https://theintercept.com/snowden-sidtoday/")
    @output = Array.new
  end

  # Get the text for the selenium item
  def get_text(url, pdf_path)
    begin
      text = File.read("../text/"+pdf_path.gsub(".pdf", ".txt")).to_s
      puts "Text Found"
    # Extract from website if it isn't there already
    rescue
      begin
        text = ""
        puts "Getting "+ url
        text = open(url).read
     
        File.write("../text/"+pdf_path.gsub(".pdf", ".txt"), text)
        puts "Wrote #{text}"
      rescue
      end
    end

    return text.gsub("<p data-reactid=\".ti.1.0.0.1.0.1.$0.0\" class=\"SidTodayFilesDetailViewer-pages-page-paragraph\">", "")
  end

  # Parses the JSON to match schema for Snowden document search
  def parse_json(item)
    itemhash = Hash.new
   
    # Parse out various fields
    itemhash[:title] = item["displayName"]["text"]
    itemhash[:pub_date] = Date.parse(item["inDocumentSets"]["edges"][0]["node"]["publishedTime"]).to_s
    itemhash[:released_date] = itemhash[:pub_date]
    itemhash[:document_date] = Date.parse(item["publishedTime"]).to_s
    itemhash[:document_topic] = ["SIDtoday"]
    itemhash[:agency] = ["NSA"]
    itemhash[:article_links] = ["https://theintercept.com/snowden-sidtoday/"]
    itemhash[:description] = item["description"]["text"]
    puts "Processing #{itemhash[:title]}"
    # Get ID and PDFs
    split_id = item["speakingId"].split("-")
    fixed_name = itemhash[:title].gsub("'", "").gsub("?", "").gsub(":", "").gsub("--", " ").gsub("(", "").gsub(")", "").gsub("...", "").gsub(",", "").gsub('"', "").gsub("!", "").gsub(" - ", " ").gsub("/", "").gsub(".", "").gsub(";", "").gsub("&", "").split(" ").join("-").gsub("-—-", "-")
    pdf_path = (itemhash[:document_date]+"-SIDToday-"+fixed_name+".pdf").gsub("Ã©", "")
    itemhash[:pdf_paths] = [pdf_path]
    
    dc_url = item["documentSource"]["url"]+".txt"    
    itemhash[:doc_text] = get_text(dc_url, pdf_path)
    itemhash[:plain_text] = itemhash[:doc_text].gsub(/<\/?[^>]*>/, "")
    
    return itemhash
  end

  # Gets the JSON from The Intercept's website
  def get_json
    html = Nokogiri::HTML(@page)
    text = open("https://theintercept.com/api/requestSIDDocuments/?orderBy=publishedTime&orderDirection=desc&perPage=2000").read
    documents = JSON.parse(text)["documents"]["edges"].map{|d| d["node"]}
    
    documents.each do |doc|
      @output.push(parse_json(doc))
    end

    return JSON.pretty_generate(@output)
  end
end

s = Sidtoday.new
File.write("sidtoday_update.json", s.get_json)

# NOTE TO UPDATE:
# 1. Pull git repo
# 2. Run script to fix names
# 3. Copy documents to docs/
# 4. Run this script
# 5. Run other update scripts as normal
