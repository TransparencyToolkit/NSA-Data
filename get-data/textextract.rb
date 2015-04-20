require 'json'
require 'sigadparse'
require 'termextractor'
require 'pry'

class TextExtract
  def initialize(input, field)
    @input = fixEncode(File.read(input))
    @field = field
    @output
  end

  # Fix encoding errors
  def fixEncode(str)
    if str.is_a?(String)
      return str.unpack('C*').pack('U*')
    else
      return str
    end
  end

  # Extracts SIGADs
  def extractSIGADs
   s = SIGADParse.new(@input, @field)
   @output = s.match
  end


  # Extract Codewords
  def extractCodewords
    e = TermExtractor.new(@output, ["doc_text", "description", "categories"], "codewords")
    e.extractSetTerms(fixEncode(File.read("../extract-lists/codewords.json")), ["codeword"], "case_sensitive")
    @output = e.getAllOutput
  end

  # Extract Countries
  def extractCountries
    f = TermExtractor.new(@output, ["doc_text", "description", "categoris"], "countries_mentioned")
    f.extractSetTerms(fixEncode(File.read("../extract-lists/isocodes.json")), ["full_name", "short_name"], "case-insensitive")
    @output = f.getAllOutput
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
