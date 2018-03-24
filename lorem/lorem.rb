#!/usr/bin/env ruby
# CLI Lorem Ipsum generator in Ruby.

# This Faker gem looks interesting
require 'optparse'
require 'faker'

# Treating options on input, initialize base values
generator_options = { lorem_ipsum: true }
particle_options = { paragraphs: 4 }

# Generator object
class LoremGenerator
  def initialize(generator_options, particle_options)
    @generator_options = generator_options
    @particle_options = particle_options
  end

  def generate
  end
end

OptionParser.new do |parser|
  parser.banner = 'CLI Lorem Ipsum generator.'

  # This is just so we don't have to type parser.on ALL the time
  parser_bool_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, description) do |opt|
      default_options[long_opt.delete('-').to_sym] = opt
    end
  }

  # Passing integers to the option
  parser_int_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, Integer, description) do |value|
      default_options[long_opt.gsub(/[A-Z-]+/, '').delete(' ').to_sym] = value
    end
  }

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  p = Lorem.new(default_options)
  puts p.generate
end
