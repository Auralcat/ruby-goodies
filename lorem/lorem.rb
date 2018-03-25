#!/usr/bin/env ruby
# CLI Lorem Ipsum generator in Ruby.

require 'optparse'
require 'faker'
require 'yaml'

# Treating options on input, initialize base values
particle_options = {}
generator_options = {}

# Example custom generator
class Cupcake
  @data = YAML.load_file("data/#{name.downcase}.yaml")
  # Static class
  class << self
    def say_my_name
      puts "My name is #{name}"
    end

    def words(number)
      @data['words'].sample(number)
    end

    def sentences(number)
      # Here we can get a random number of words.
      # Capitalize the first one and put a period in the last one.
      out = []
      number.times do
        buf = [words(1).pop.capitalize]
        buf.concat(words(Random.rand(6..9)))
        buf << words(1).pop + '.'
        out << buf.join(' ')
      end
      out
    end

    def paragraph(number)
      # Join a random number of sentences.
      out = []
      number.times do
        out << sentences(Random.rand(3..7)).join(" ")
      end
      out
    end
  end
end

# Generator object
class LoremGenerator
  def initialize(particle, generator)
    @particle = particle
    @generator = generator
  end

  # You can only generate one of either paragraphs, phrases or words.
  def generate
    if @particle[:paragraphs]
      @generator.paragraphs(@particle[:paragraphs]).join("\n")
    elsif @particle[:sentences]
      @generator.sentences(@particle[:sentences]).join(' ')
    elsif @particle[:words]
      @generator.words(@particle[:words]).join(' ')
    end
  end
end

OptionParser.new do |parser|
  parser.banner = 'CLI Lorem Ipsum generator.'

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

  # Generator options
  parser.on('-l', '--lorem-ipsum', 'Use words from Lorem Ipsum') do
    generator_options = Faker::Lorem
  end

  parser.on('-c', '--cupcake', 'Use names of sweets (Cupcake Ipsum)') do
    generator_options = Cupcake
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
    generator_options = Faker::Lorem if generator_options.empty?
    p = LoremGenerator.new(particle_options, generator_options)
    puts p.generate
  rescue ArgumentError
    puts "Inputting two of either generator or particle options is not allowed.
Generator options are: -l (lorem)
Particle options are: -w (words), -s (sentences) and -p (paragraph).

Usage: lorem (-w -s -p) NUMBER (Either option w, s OR p.)"
  end
end
