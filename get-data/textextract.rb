require 'json'
require 'sigadparse'

class TextExtract
  def initialize(input, field)
    @input = File.read(input)
    @field = field
    @output
  end

  # Extracts SIGADs
  def extractSIGADs
    s = SIGADParse.new(@input, @field)
    @output = s.match
  end

  # To add: 
  #extractCodewords
  #extractCountries

  # Runs all the extract methods
  def extractAll
    extractSIGADs
    return @output
  end
end

t = TextExtract.new("feed.json", "doc_text")
puts t.extractAll
