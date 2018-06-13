require 'optparse'

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
OptionParser.new do |parser|
  parser.banner = 'Quote your strings!'

  parser_particle_proc = proc do |short_opt, long_opt, description|
    parser.on(short_opt, long_opt, description) do |value|
      particle_options[long_opt.gsub(/[A-Z-]+/, '').delete(' ').to_sym] = value
    end
  end

  # Display help message
  parser.on('-h',
            '--help',
            'Display this help message.') do
    puts parser
  end

  # Generator options
  parser.on('-s', '--single', 'Return input in single quotes') do
    options[:single] = true
  end

  parser.on('-d', '--double', 'Return input in double quotes') do
    options[:double] = true
  end
end.parse!

# Execute when called from the command line.
# Equivalent to Python's if __name__ == "main"
if $PROGRAM_NAME == __FILE__
  begin
    # Placeholder
  rescue ArgumentError
    abort 'Choosing single and double quotes at the same time is not allowed.'\
      '\n\nUsage: quote [-s|-d] INPUT'
  end
end
