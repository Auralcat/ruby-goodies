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
      puts "buf has more than one word: #{buf}"
      buf.split(' ').each do |item|
        html_classes << item
      end
    else
      html_classes << buf
    end
  end
end

puts html_classes.uniq
puts "#{html_classes.uniq.length} classes have been scraped."
