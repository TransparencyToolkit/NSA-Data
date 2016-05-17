require 'pry'

class FixFileNames
  def initialize(path, output_dir)
    @path = path
    @output_dir = output_dir
  end

  # Change the names
  def fix_names
    Dir.foreach(@path) do |file|
      next if file == '.' or file == '..'
      fixed_name = file.gsub("_", "-").gsub("----", "-").gsub("---", "-").gsub("--", "-")

      File.write(@output_dir+fixed_name, File.read(@path+file))
    end
  end
end

f = FixFileNames.new("/home/shidash/Data/sidtoday/documents/2003/", "/home/shidash/Data/sidtoday/documents/2003_fixed/")
f.fix_names
