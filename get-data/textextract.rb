require 'json'
require 'sigadparse'
require 'entityextractor'

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


  # Extract Codewords
  def extractCodewords
    e = EntityExtractor.new(@output, "codewords", "doc_text", "description", "categories")
    e.extract("set", nil, nil, JSON.parse(File.read("../extract-lists/codewords.json")), ["description"], ["hashkey", "codeword"], "key", nil)
    @output = e.genJSON
  end

  # Extract Countries
  def extractCountries
    f = EntityExtractor.new(@output, "countries_mentioned", "doc_text", "description", "categories")
    f.extract("set", nil, nil, JSON.parse(File.read("../extract-lists/isocodes.json")), ["key", "two_letter_iso", "three_letter_iso"], "key", nil)
    @output = f.genJSON
  end

  # Runs all the extract methods
  def extractAll
    extractSIGADs
    extractCodewords
    extractCountries
    return @output
  end
end

t = TextExtract.new("feed.json", "doc_text")
puts t.extractAll
