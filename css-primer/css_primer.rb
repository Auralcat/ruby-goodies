# The idea here is to generate a CSS file from a HTML file.
# We'll use Nokogiri to do the parsing

require 'nokogiri'
require 'optparse'

# Get this through optparse
file_path = ""
# Open file using Nokogiri
html_file = Nokogiri::HTML(open(Dir.home + "/parse_this.html"))

# Extra step: ensure HTML is well formed

# Put all found classes in here
html_classes = []
html_file.css('*').each do |element|
  buf = element.attr('class')
  if !buf.nil?
    if buf.include?(" ")
      buf.split(' ').each do |item|
        html_classes << item
      end
    else
      html_classes << buf
    end
  end
end
# ^ The same can be done for extracting ids.

# I just need one occurrence of each item, and no empty strings!
html_classes.uniq!.filter!{|x| x != ""}
puts "#{html_classes.length} classes have been scraped."

=begin
Now that I have the classes, I want the output to be like this:
.class-name {

}

.another-class {

}
=end
html_classes.each do |item|
  puts ".#{item} {\n\n}\n\n"
end

# Write this to a file
