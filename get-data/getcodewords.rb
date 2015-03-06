require 'json'
require 'nokogiri'
require 'open-uri'

class GetCodewords
  def initialize
    @codeword_list = Nokogiri::HTML(open("http://electrospaces.blogspot.nl/p/nicknames-and-codewords.html"))
    @words_and_desc = Array.new
  end

  # Downloads all codewords
  def download
    splittext = @codeword_list.text.split("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z").last.split("- See also this list of NSA codewords from 2002").first
    splitlist = splittext.split("back to top")

    # Loop through the list for each letter
    splitlist.each do |letter_list|
      letter_list.each_line do |line|
        if line.include? " - "
          ls = line.split(" - ")
          temphash = Hash.new
          temphash[:codeword] = ls[0]
          temphash[:description] = ls[1]
          @words_and_desc.push(temphash)
        end
      end
    end
  end

  # Formatted list with variations
  def makeList
    download
    JSON.pretty_generate(@words_and_desc)
  end

  # To do:
  # Merge with existing list
  # Key/consistent allcaps version
  # Lowercase where appropriate
  # CamelCase
  # With a space
  # Abbreviations in parentheses
  # Any other variations
end

g = GetCodewords.new
puts g.makeList
