require 'json'
require 'nokogiri'
require 'open-uri'

class GetCodewords
  def initialize
    @nsa_list = Nokogiri::HTML(open("http://electrospaces.blogspot.nl/p/nicknames-and-codewords.html"))
    @gchq_list = Nokogiri::HTML(open("http://electrospaces.blogspot.nl/p/gchq-nicknames-and-codewords.html"))
    @words_and_desc = Hash.new
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

  # Loop through the list for each letter
  def getList(data)
    data.each do |letter_list|
      letter_list.each_line do |line|
        if line.include? " - "
          ls = line.split(" - ")
          @words_and_desc[ls[0]] = { codeword: ls[0], description: ls[1]}
        end
      end
    end
  end

  # Formatted list with variations
  def makeList
    downloadNSA
    downloadGCHQ
    JSON.pretty_generate(@words_and_desc)
  end

  # To do:
  # Lowercase where appropriate
  # Allcaps one word
  # CamelCase
  # With a space
  # Abbreviations in parentheses
  # Any other variations
  # Remove parentheses from keys
  # Merge with existing/edited list
end

g = GetCodewords.new
puts g.makeList
