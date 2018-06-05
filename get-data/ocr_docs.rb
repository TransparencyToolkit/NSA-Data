require 'pry'

Dir.foreach('../to_ocr/') do |file|
  next if (file == ".") || (file == "..")
  puts "OCRing #{file}"
  text = %x[abbyyocr11 -c -if ../to_ocr/#{file} -f TextVersion10Defaults -tel -tet UTF8 -tcp Latin].gsub(/\xef\xbb\xbf/, "")
  save_path = "../text/"+file.gsub("."+file.split(".")[1], ".txt")
  puts text
  File.write(save_path, text)
end
