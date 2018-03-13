#!/usr/bin/env ruby
# CLI password generator in Ruby.

require 'optparse'

ALL_CHARS = (32).upto(126).map{|n| n.chr} # includes parens, brackets, etc
ALPHANUMERIC = "a".upto("z").to_a
  .concat("A".upto("Z").to_a)
  .concat("0".upto("9").to_a)

emoji_file_path = Dir.home + "/ruby-goodies/passgen/emoji-list.txt"
EMOJI = File.readlines(emoji_file_path).map{|line| line.chomp}

# This is the logic part of the program
class PasswordGenerator

  def initialize(options)
    @options = options
  end

  def has_emoji?
    # Looks for words like :high_heeled_shoe: <- like this
    # For that we'll need to call the sampling BEFORE converting the words to
    # emoji in the script.

    if @options[:emoji]
      # Do the usual set sampling
      test_sample = EMOJI.sample(@options[:length]).join
      !test_sample.match(/:\w+:/).nil?
    else
      false
    end

  end

  def has_non_alpha_chars?
    self.generate.match(/^[a-zA-Z0-9_]*$/).nil?
  end

  def generate
    output = []
    @options[:count].times do
      if @options[:emoji]
        # We'll need an extra script to show emoji in the shell.
        # For now I'm using emojify

        # We need to put a space between the aliases for emojify to work
        raw_emoji_sample = EMOJI.sample(@options[:length]).join(" ")
        output << `emojify #{raw_emoji_sample}`.delete(" ")
      elsif @options[:alphanumeric]
        output << ALPHANUMERIC.sample(@options[:length]).join
      else
        output << ALL_CHARS.sample(@options[:length]).join
      end
    end
    output.join("\n")
  end

end

# Treating options on input, initialize base values
default_options = {:length => 10, :count => 1}

OptionParser.new do |parser|
  parser.banner = "CLI password generator."

  # This is just so we don't have to type parser.on ALL the time
  parser_bool_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, description) do |opt|
      default_options[long_opt.gsub("-", "").to_sym] = opt
    end
  }

  # Passing integers to the option
  parser_int_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, Integer, description) do |value|
      default_options[long_opt.gsub(/[A-Z-]+/, "").delete(" ").to_sym] = value
    end
  }

  # Working with the boolean options
  parser_bool_proc.call("-a", "--alphanumeric",
                        "Generate password only with letters and numbers")
  parser_bool_proc.call("-e", "--emoji", "Generate emoji-only passwords")

  # Options that take a number as argument
  parser_int_proc.call("-c", "--count COUNT", "Generate COUNT passwords")
  parser_int_proc.call("-l", "--length LENGTH",
                       "Generate password with length LENGTH. Default is 10.")

  # This is a different case
  parser.on("-h",
            "--help",
            "Display this help message.") do ||
    puts parser
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if __FILE__ == $0
  p = PasswordGenerator.new(default_options)
  puts p.generate
end
