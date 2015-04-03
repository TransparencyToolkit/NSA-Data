require 'json'
require 'nokogiri'
require 'open-uri'

class GetCodewords
  def initialize
    @nsa_list = Nokogiri::HTML(open("http://electrospaces.blogspot.nl/p/nicknames-and-codewords.html"))
    @gchq_list = Nokogiri::HTML(open("http://electrospaces.blogspot.nl/p/gchq-nicknames-and-codewords.html"))
    @cse_list = Nokogiri::HTML(open("http://electrospaces.blogspot.de/p/cse-codewords-and-abbreviations.html"))
    @words_and_desc = Hash.new
    @current_list = JSON.parse(File.read("../extract-lists/codewords.json"))
  end

  # Downloads all codewords
  def downloadNSA
    splittext = @nsa_list.text.split("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z").last.split("- See also this list of NSA codewords from 2002").first
    splitlist = splittext.split("back to top")
    getList(splitlist)
  end

  # Download GCHQ codewords
  def downloadGCHQ
    splittext = @gchq_list.text.split("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z").last.split("- See also the codenames of JTRIG tools and techniques").first
    splitlist = splittext.split("back to top")
    getList(splitlist)
  end

  # Download CSE codewords
  def downloadCSE
    splittext = @cse_list.to_s.split('<a name="codewords">').last.split('<a name="abbreviations">').first
    splitlist = Array.new
    splittext.split('<font size="+1">').each do |s|
      splitlist.push(Nokogiri::HTML::fragment(s).text)
    end
    getList(splitlist)
  end

  # Loop through the list for each letter
  def getList(data)
    data.each do |letter_list|
      letter_list.each_line do |line|
        if line.include? " - "
          ls = line.split(" - ")
          if @current_list[ls[0]] && @current_list[ls[0]]["modified"] == "Yes"
            @words_and_desc[ls[0]] = @current_list[ls[0]]
          else
            @words_and_desc[ls[0]] = { codeword: [ls[0], ls[0].gsub(" ", "")].uniq, description: ls[1], case_sensitive: "No", modified: "No"}
          end
        end
      end
    end
  end

  # Formatted list with variations
  def makeList
    downloadNSA
    downloadGCHQ
    downloadCSE
    JSON.pretty_generate(@words_and_desc)
  end
end

g = GetCodewords.new
puts g.makeList
