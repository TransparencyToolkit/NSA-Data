require 'open-uri'
require 'nokogiri'
require 'json'

class FeedParser
  def initialize
    @results = Array.new
  end

  # Get all items from feed
  def pullItems
    (1..60).each do |num|
      feed = Nokogiri::XML(open('https://freesnowden.is/feed?paged='+num.to_s))
      feed.xpath('//item').each do |i| 
        item_parsed = parseItem(i)
        if item_parsed[:categories].include? "Revealed documents"
          @results.push(parseItem(i))
        end
      end
    end
    
    JSON.pretty_generate(@results)
  end

  # Handle fields with multiple results
  def handleMultiple(xpath)
    grouparr = Array.new
    xpath.each do |v|
      grouparr.push(getText(v))
    end
    
    return grouparr
  end

  # Get item if it exists
  def getText(raw)
    return raw.text if raw
  end

  # Extract list of terms from categories
  def extractFromCategories(categories, extractlist)
    json = JSON.parse(File.read(extractlist))
    outarr = Array.new
    
    json.each do |e|
      if categories.include?(e["Tag"]) || categories.include?(e["Tag"].downcase)
        outarr.push(e["HR Tag"])
      end
    end

    return outarr.uniq
  end

  # Parse item attributes
  def parseItem(i)
    temphash = Hash.new
    temphash[:title] = getText(i.at('title'))
    temphash[:link] = getText(i.at('link'))
    temphash[:pub_date] = getText(i.at('pubDate'))
    temphash[:categories] = handleMultiple(i.xpath('category'))
    temphash[:document_topic] = extractFromCategories(temphash[:categories], "../extract-lists/document_topic.json")
    temphash[:agency] = extractFromCategories(temphash[:categories], "../extract-lists/agencies.json")
    temphash[:description] = getText(i.at('description')).gsub(" Download link", "")
    temphash[:document_date] = getText(i.at('document_date'))
    temphash[:released_date] = getText(i.at('released_date'))
    temphash[:pdf] = handleMultiple(i.xpath('pdfs').xpath('pdf'))
    
    return temphash
  end
end

f = FeedParser.new
puts f.pullItems
