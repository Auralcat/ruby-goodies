#!/usr/bin/env ruby
require 'optparse'

# Extending the String class
class String
  def single_quote
    # Returns the string with ''s
    "'" + self + "'"
  end

  def double_quote
    # Returns the string with ""s
    '"' + self + '"'
  end

  def parens
    # Returns the string with ()s
    '( ' + self + ' )'
  end

  def brackets
    # Returns the string with []
    '[ ' + self + ' ]'
  end

  def braces
    # Returns the string with {}s
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

  parser.on('-b', '--braces', 'Return input in braces') do
    puts STDIN.read.split(' ').map(&:braces).join(' ')
  end

  parser.on('-d', '--double', 'Return input in double quotes') do
    options[:single] = false
  end

  parser.on('-p', '--parens', 'Return input in parentheses') do
    puts STDIN.read.split(' ').map(&:parens).join(' ')
  end

  parser.on('-s', '--brackets', 'Return input in brackets') do
    puts STDIN.read.split(' ').map(&:brackets).join(' ')
  end

  parser.on('-P', '--phrase', 'Quote an entire phrase') do
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
      puts STDIN.read.split(' ').map(&:single_quote).join(' ')
    else
      puts STDIN.read.split(' ').map(&:double_quote).join(' ')
    end
  rescue OptionParser::ParseError
    abort 'Leaving program.'
  end
end
