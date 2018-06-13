#!/usr/bin/env ruby
require 'optparse'

# Extending the String class
class String
  def single_quote
    # Returns the string with single quotes
    "'" + self + "'"
  end

  def double_quote
    # Returns the string with single quotes
    '"' + self + '"'
  end
end

# OptionParser code
OptionParser.new do |parser|
  parser.banner = 'Quote your strings!'

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end

  # Generator options
  parser.on('-s', '--single', 'Return input in single quotes') do
    puts ARGV.map(&:single_quote).join(' ')
  end

  parser.on('-d', '--double', 'Return input in double quotes') do
    puts ARGV.map(&:double_quote).join(' ')
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  begin
  rescue OptionParser::ParseError
    abort 'Choosing single and double quotes at the same time is not allowed.'\
      '\n\nUsage: quote [-s|-d] INPUT'
  end
end
