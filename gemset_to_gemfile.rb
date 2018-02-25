# Export file.gems to Gemfile format

gems = File.read('default.gems').split("\n")
gems.map!{ |gem| gem.gsub("-v", "").split(" ") }
File.open("Gemfile", "w") do |f|
  f.puts "source 'https://rubygems.org'\n"
  gems.each do |gem|
    f.puts "gem '#{gem[0]}', '#{gem[1]}'"
  end
end
