# CLI password generator in Ruby.

require 'optparse'

# This is the logic part of the program
class PasswordGenerator

  # Initialize constants
  ALL_CHARS = (32).upto(126).map{|n| n.chr} # includes parens, brackets, etc
  ALPHANUMERIC = "a".upto("z").to_a
    .concat("A".upto("Z").to_a)
    .concat("0".upto("9").to_a)

  def initialize(options)
    @options = options
  end

  def generate
    if @options[:alpha]
      ALPHANUMERIC.sample(@options[:length]).join
    else
      ALL_CHARS.sample(@options[:length]).join
    end
  end

  def output

  end
end

# Treating options on input
options = {}

OptionParser.new do |parser|
  parser.banner = "CLI password generator."

  parser.on("-a",
            "--alphanumeric",
            "Generate password only with letters and numbers") do |v|
    options[:alpha] = v
  end

  parser.on("-h",
            "--help",
            "Display this help message.") do ||
    puts parser
  end

  parser.on("-l",
            "--length LENGTH",
            Integer,
            "Generate password with length LENGTH. Default is 10.") do |l|
    options[:length] = l
  end
end.parse!

p = PasswordGenerator.new(options)
puts p.generate
