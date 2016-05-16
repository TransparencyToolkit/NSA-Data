require 'json'

iso = JSON.parse(File.read("isocodes.json"))
all_countries = Array.new

iso.each do |key, value|
  country_name = value["short_name"] ? value["short_name"] : value["full_name"]
  fix_name = country_name.split("(")
  fix_name = fix_name[0].gsub("'", "").gsub('"', "")
  all_countries.push(fix_name)
end

puts JSON.pretty_generate(all_countries)
# US, UK, Laos, Syria
