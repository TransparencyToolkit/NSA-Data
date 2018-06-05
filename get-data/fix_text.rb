require 'pry'

# Cleans up stray weird HTML in the text
Dir.foreach('../text/') do |file|
  next if (file == ".") || (file == "..")
  text = File.read("../text/"+file)
  if text.include?('<p data-reactid=')
    text = text.gsub('<p data-reactid=".ti.1.0.0.1.0.1.$0.0" class="SidTodayFilesDetailViewer-pages-page-paragraph">', "")
    text = text.gsub('<p data-reactid=".ti.1.0.0.1.0.1.$0.0" class="SidTodayFilesDetailViewer-pages-page-paragraph">', "")
    text = text.gsub('<p data-reactid=".ti.1.0.0.1.0.1.$1.0" class="SidTodayFilesDetailViewer-pages-page-paragraph">', "")
    text = text.gsub('<p data-reactid=".ti.1.0.0.1.0.1.$2.0" class="SidTodayFilesDetailViewer-pages-page-paragraph">', "")
    text = text.gsub('<p data-reactid=".ti.1.0.0.1.0.1.$3.0" class="SidTodayFilesDetailViewer-pages-page-paragraph">', "")
    
    puts "Fixing #{file}"
    File.write("../text/"+file, text)
  end
end
