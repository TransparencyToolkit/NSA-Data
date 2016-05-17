require 'open-uri'
require 'nokogiri'
require 'json'
require 'selenium-webdriver'
require 'american_date'
require 'pry'

class Sidtoday
  def initialize
    @page = open("https://theintercept.com/snowden-sidtoday/")
    @output = Array.new
  end

  # Get the text for the selenium item
  def get_text(url)
    text = ""
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['intl.accept_languages'] = 'en'
    browser = Selenium::WebDriver.for :firefox, profile: profile
    browser.navigate.to url

    # Extract text
    sleep(1)
    browser.find_element(:css, ".SidTodayFilesDetailViewer-navigation-display-text").click
    html = Nokogiri::HTML(browser.page_source)
    paragraphs = html.css(".SidTodayFilesDetailViewer-pages-page-paragraph")
    text = paragraphs.to_s
   
    # Close and return
    browser.quit
    return text
  end

  # Parses the JSON to match schema for Snowden document search
  def parse_json(item)
    itemhash = Hash.new

    # Parse out various fields
    itemhash[:title] = item["title"]
    itemhash[:pub_date] = Date.parse(item["published_online_date"]).to_s
    itemhash[:released_date] = itemhash[:pub_date]
    itemhash[:document_date] = Date.parse(item["document_date"]).to_s
    itemhash[:document_topic] = ["SIDtoday"]
    itemhash[:agency] = ["NSA"]
    itemhash[:description] = item["description"]

    # Get ID and PDFs
    split_id = item["id"].split("-")
    pdf_path = itemhash[:document_date]+"-SIDToday-"+split_id.slice(1, split_id.length-1).join("-")+".pdf"
    itemhash[:pdf_paths] = [pdf_path]

    intercept_url = "https://theintercept.com/snowden-sidtoday/"+split_id.join("-").downcase
    itemhash[:doc_text] = get_text(intercept_url)

    return itemhash
  end

  # Gets the JSON from The Intercept's website
  def get_json
    html = Nokogiri::HTML(@page)
    documents = JSON.parse(html.css("script")[1].text.split("window.initialStoreTree = ")[1].split("window.config = ")[0])["sidTodayFiles"]["archive"]

    documents.each do |doc|
      @output.push(parse_json(doc))
    end

    return JSON.pretty_generate(@output)
  end
end

s = Sidtoday.new
puts s.get_json

# NOTE TO UPDATE:
# 1. Pull git repo
# 2. Run script to fix names
# 3. Copy documents to docs/
# 4. Run this script
# 5. Run other update scripts as normal
