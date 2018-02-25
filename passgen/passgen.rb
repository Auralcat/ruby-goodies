#!/usr/bin/env ruby
# CLI password generator in Ruby.

require 'optparse'

# Initialize constants
ALL_CHARS = (32).upto(126).map{|n| n.chr} # includes parens, brackets, etc
ALPHANUMERIC = "a".upto("z").to_a
  .concat("A".upto("Z").to_a)
  .concat("0".upto("9").to_a)

buf = []
File.foreach('emoji-list.txt') do |line|
  buf << line.chomp
end

EMOJI = buf

# This is the logic part of the program
class PasswordGenerator

  def initialize(options)
    @options = options
  end

  def generate
    if @options[:emoji]
      # We'll need an extra script to show emoji in the shell.
      # For now I'm using emojify

      # We need to put a space between the aliases for emojify to work
      `emojify #{EMOJI.sample(@options[:length]).join(" ")}`.delete(" ")
    elsif @options["alphanumeric"]
      ALPHANUMERIC.sample(@options[:length]).join
    else
      ALL_CHARS.sample(@options[:length]).join
    end
  end

end

# Treating options on input, initialize base values
options = {:length => 10, :count => 1}

OptionParser.new do |parser|
  parser.banner = "CLI password generator."

  # This is just so we don't have to type parser.on ALL the time
  parser_proc = -> (short_option, long_option, description) {
    parser.on(short_option, long_option, description) do |opt|
      options[long_option.gsub("-", "")] = opt
    end
  }

  parser_proc.call("-t", "--test", "Option for testing procs")

  # parser.on("-a",
  #           "--alphanumeric",
  #           "Generate password only with letters and numbers") do |v|
  #   options[:alpha] = v
  # end

  parser_proc.call("-a", "--alphanumeric", "Generate password only with letters and numbers")

  parser.on("-c",
            "--count COUNT",
            Integer,
            "Generate COUNT passwords") do |c|
    options[:count] = c
  end

  parser.on("-e",
           "--emoji",
           "Generate emoji-only passwords") do |e|
    options[:emoji] = e
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

# Tie everything together
p = PasswordGenerator.new(options)

options[:count].times do
  puts p.generate
end
