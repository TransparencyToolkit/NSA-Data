require 'open-uri'
require 'nokogiri'
require 'json'

class FeedParser
  def initialize
    @results = Array.new
  end

  # Get all items from feed
  def pullItems
    (1..63).each do |num|
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

  # Get PDFs
  def downloadPDFs(pdfs)
    patharr = Array.new

    pdfs.each do |p|
      path = p.split("/").last
      if !File.exist?("../docs/"+path)
        begin
          # Handle url errors
          if !p.include?("http")
            p = "http://freesnowden.is"+p
          elsif p.include?("edard") || p.include?("snowen")
            path = p.split(".com")
            p = "http://freesnowden.is"+path[1]
          elsif p.include?(",com")
            p = p.gsub(",com", ".com")
          end

          # Get document
          `wget --no-check-certificate -P ../docs #{p.gsub("https", "http")}`
        rescue => error
        end
      end
      patharr.push(path)
    end

    return patharr
  end
  
  # Get text for the document (from text folder)
  def getDocText(paths)
    text = ""
    paths.each do |p|
      text += p+": \n" if paths.length > 1
      begin
        text += File.read("../text/"+p.gsub(".pdf", ".txt"))
      rescue
      end
    end  

    return text
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
    temphash[:pdf_paths] = downloadPDFs(temphash[:pdf])
    #temphash[:doc_text] = getDocText(temphash[:pdf_paths])
    
    return temphash
  end
end

f = FeedParser.new
puts f.pullItems
