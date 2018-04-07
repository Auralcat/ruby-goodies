# The idea here is to generate a CSS file from a HTML file.
# We'll use Nokogiri to do the parsing

require 'nokogiri'
require 'optparse'

# Get this through optparse
file_path = ""
# Open file using Nokogiri
html_file = Nokogiri::HTML.open(file_path)

# Extra step: ensure HTML is well formed

# Put all found classes in here
html_classes = []
html_file.css('*').each do |element|
  buf = element.attr('class').value
  if buf.include?(" ")
    buf.split(' ').each do |item|
      html_classes << item
    end
  end
  html_classes << buf if buf != nil
end
