require 'open-uri'
require 'nokogiri'
require 'json'
require 'htmlentities'

# Get only new pdfs cp `git diff --name-only b9a1911 e81b5fb` new_dir

class FeedParser
  def initialize
    @results = Array.new
  end

  # Get all items from feed
  def pullItems
    (1..80).each do |num|
      begin
        feed = Nokogiri::XML(open('https://edwardsnowden.com/feed?paged='+num.to_s))
        feed.xpath('//item').each do |i| 
          item_parsed = parseItem(i)
          if item_parsed[:categories].include? "Revealed documents"
            @results.push(parseItem(i))
          end
        end
      rescue
      end
    end

    add_sidtoday
    JSON.pretty_generate(@results)
  end

  # Add SIDtoday items
  def add_sidtoday
    sid = JSON.parse(File.read("sidtoday.json"))
    @results = @results + sid
  end

  # Delete documents that aren't Snowden docs
  def deleteNonRevDoc
    json = JSON.parse(File.read("feed2.json"))
    
    # Check all files in dir
    Dir.glob("../docs/*") do |file|
      # Set file path and flag
      file_path = file.split("/").last
      found_flag = 0

      # Check against paths in json items
      json.each do |i|
        i["pdf_paths"].each do |pdf_path|
          found_flag = 1 if pdf_path == file_path
        end
      end

      # Delete if there is no match
      File.delete("../docs/"+file_path) if found_flag == 0
    end
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
    return HTMLEntities.new.decode(raw.text) if raw
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

  # Find any agencies mentioned in categories as agencyname_orig
  def getAgency(categories)
    agencyarray = Array.new

    categories.each do |c|
      if c.include? "_orig"
        agencyarray.push(c.gsub("_orig", "").upcase)
      end
    end

    return agencyarray.uniq
  end

  # Get external links
  def getExternalLinks(i)
    links = handleMultiple(i.xpath('extlinks').xpath('link'))
    return links
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
        text += File.read("../text/"+p.gsub(".pdf", ".txt").gsub(".jpg", ".txt").gsub(".png", ".txt").gsub(".jpeg", ".txt").gsub(".gif", ".txt"))
      rescue
      end
    end  

    return text
  end

  # Get documents, both images and PDFs
  def getDocPaths(i)
    pdfs = handleMultiple(i.xpath('pdfs').xpath('pdf'))
    images = handleMultiple(i.xpath('images').xpath('img'))
    return pdfs.push(*images)
  end

  # Parse item attributes
  def parseItem(i)
    temphash = Hash.new
    temphash[:title] =  getText(i.at('title'))
    temphash[:link] = getText(i.at('link'))
    temphash[:pub_date] = getText(i.at('pubDate'))

    temphash[:categories] = handleMultiple(i.xpath('category'))
    temphash[:document_topic] = extractFromCategories(temphash[:categories], "../extract-lists/document_topic.json")
    temphash[:agency] = getAgency(temphash[:categories])

    # Get doc info iff it is a Snowden doc
    if temphash[:categories].include?("Revealed documents")
      temphash[:description] = getText(i.at('description')).gsub(" Download link", "")
      temphash[:document_date] = getText(i.at('document_date'))
      temphash[:released_date] = getText(i.at('released_date'))
      temphash[:pdf] = getDocPaths(i)
      temphash[:pdf_paths] = downloadPDFs(temphash[:pdf])
      temphash[:article_links] = getExternalLinks(i)
      temphash[:doc_text] =  HTMLEntities.new.decode(getDocText(temphash[:pdf_paths]))
      temphash[:plain_text] = temphash[:doc_text].gsub(/<\/?[^>]*>/, "")
    end
    
    return temphash
  end
end

f = FeedParser.new
puts f.pullItems

