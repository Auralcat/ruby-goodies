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
options = { single: true }
OptionParser.new do |parser|
  parser.banner = 'Quote your strings! (default: single quote)'

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end

  # Generator options
  parser.on('-d', '--double', 'Return input in double quotes') do
    options[:single] = false
  end

  parser.on('-p', '--phrase', 'Quote an entire phrase') do
    if options[:single]
      puts STDIN.read.chomp.single_quote
    else
      puts STDIN..read.chomp.double_quote
    end
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  begin
    # raise OptionParser::ParseError, 'Only one option is allowed' if options.values.all?
    if options[:single]
      puts STDIN.map(&:single_quote).join(' ')
    else
      puts STDIN.map(&:double_quote).join(' ')
    end
  rescue OptionParser::ParseError
    abort 'Leaving program.'
  end
end
