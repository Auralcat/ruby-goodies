#!/usr/bin/env ruby
# CLI Lorem Ipsum generator in Ruby.

# This Faker gem looks interesting
require 'optparse'
require 'faker'

# Treating options on input, initialize base values
particle_options = {}
generator_options = {}

# Generator object
class LoremGenerator
  def initialize(particle_options, generator_options)
    @particle_options = particle_options
    @generator_options = generator_options
  end

  # You can only generate one of either paragraphs, phrases or words.
  def generate
    if @particle_options[:paragraphs]
      Faker::Lorem.paragraphs(@particle_options[:paragraphs]).join("\n")
    elsif @particle_options[:sentences]
      Faker::Lorem.sentences(@particle_options[:sentences]).join(' ')
    elsif @particle_options[:words]
      Faker::Lorem.words(@particle_options[:words]).join(' ')
    end
  end
end

OptionParser.new do |parser|
  parser.banner = 'CLI Lorem Ipsum generator.'

  parser_generator_proc = -> (short_opt, long_opt, description) {
    parser.on(short_opt, long_opt, description) do |opt|
      generator_options[long_opt.delete('-').to_sym] = opt
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
                            '--words WORDS',
                            'Generate WORDS words.')
  parser_particle_proc.call('-s',
                            '--sentences SENTENCES',
                            'Generate SENTENCES sentences.')
  parser_particle_proc.call('-p',
                            '--paragraphs PARAGRAPHS',
                            'Generate PARAGRAPHS paragraphs.')
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  begin
    particle_options = { paragraphs: 4 } if particle_options.empty?
    generator_options = { lorem_ipsum: true } if generator_options.empty?
    p = LoremGenerator.new(particle_options, generator_options)
    puts p.generate
  rescue ArgumentError
    puts "Inputting two of either generator or particle options is not allowed.
Generator options are: -l (lorem)
Particle options are: -w (words), -s (sentences) and -p (paragraph).

Usage: lorem (-w -s -p) NUMBER (Either option w, s OR p.)"
  end
end
