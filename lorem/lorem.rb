#!/usr/bin/env ruby
# CLI Lorem Ipsum generator in Ruby.

# This Faker gem looks interesting
require 'optparse'
require 'faker'

# Treating options on input, initialize base values
particle_options = { paragraphs: 4 }

# Helper selector object
class OptionSelector
  def initialize(generators, particles)
    @generators = generator_options
    @particles = particle_options
  end
end

# Generator object
class LoremGenerator
  def initialize(particle_options)
    @particle_options = particle_options
  end

  # You can only generate one of either paragraphs, phrases or words.
  # If a conflict comes up, pick the shortest one.
  def generate

  end
end

OptionParser.new do |parser|
  parser.banner = 'CLI Lorem Ipsum generator.'

  # This is just so we don't have to type parser.on ALL the time
  parser_generator_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, description) do |opt|
      default_options[long_opt.delete('-').to_sym] = opt
    end
  }

  # Passing integers to the option
  parser_particle_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, Integer, description) do |value|
      particle_options[long_opt.gsub(/[A-Z-]+/, '').delete(' ').to_sym] = value
    end
  }

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end

  # Particle options
  parser_particle_proc.call('-w',
                       '--words',
                       'Generate WORDS words.')
  parser_particle_proc.call('-s',
                       '--sentences',
                       'Generate SENTENCES sentences.')
  parser_particle_proc.call('-p',
                       '--paragraphs',
                       'Generate PARAGRAPHS paragraphs.')
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  p = Lorem.new(default_options)
  puts p.generate
end
