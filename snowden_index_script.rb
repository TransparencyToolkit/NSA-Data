require 'curb'
require 'json'

Dir["processed_data/*"].each do |file|
  json = JSON.pretty_generate(JSON.parse(File.read(file)))
  c = Curl::Easy.new("http://localhost:3000/add_items")
  c.http_post(Curl::PostField.content("item_type", "SnowdenDoc"),
              Curl::PostField.content("index_name", "nsadocs"),
              Curl::PostField.content("items", json))
end
