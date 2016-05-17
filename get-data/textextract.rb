require 'json'
require 'sigadparse'
require 'termextractor'
require 'active_support/core_ext/hash'
require 'htmlentities'

class TextExtract
  def initialize(input, field)
    @input = File.read(input)
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
    # Extract case insensitive from categories
    d = TermExtractor.new(@output, ["categories"], "codewords")
    d.extractSetTerms(fixEncode(File.read("../extract-lists/codewords.json")), ["codeword"], "case-insensitive")
    out = d.getAllOutput

    # Extract sometimes case sensitive from text
    e = TermExtractor.new(@output, ["plain_text", "description"], "codewords")
    e.extractSetTerms(fixEncode(File.read("../extract-lists/codewords.json")), ["codeword"], "case_sensitive")
    out2 = e.getAllOutput
    mergeResults(JSON.parse(out), JSON.parse(out2), "codewords")
  end

  # Merge results in same extract field
  def mergeResults(set1, set2, field)
    outarr = Array.new
    set1.each do |item1|
      set2.each do |item2|
        if item1.except(field) == item2.except(field)
          item1[field].zip(item2[field]).flatten.compact.uniq!
          outarr.push(item1)
        end
      end
    end
    @output = JSON.pretty_generate(outarr)
  end

  # Extract Countries
  def extractCountries
    f = TermExtractor.new(@output, ["plain_text", "description", "categories"], "countries_mentioned")
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

t = TextExtract.new("feed.json", "plain_text")
puts t.extractAll
