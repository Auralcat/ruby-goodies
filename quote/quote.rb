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
options = {}
OptionParser.new do |parser|
  parser.banner = 'Quote your strings!'

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end

  # Generator options
  parser.on('-s', '--single INPUT', 'Return input in single quotes') do
    options[:single] = true
    puts ARGV.map(&:single_quote).join(' ')
  end

  parser.on('-d', '--double INPUT', 'Return input in double quotes') do
    options[:double] = true
    puts ARGV.map(&:double_quote).join(' ')
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  begin
    raise OptionParser::ParseError, 'Only one option is allowed' if options.values.all?
  rescue
    abort 'Leaving program.'
  end
end
