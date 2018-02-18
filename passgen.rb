# CLI password generator in Ruby.

require 'optionparser'

class PasswordGenerator
  attr_accessor :length
  ALL_CHARS = (32).upto(126).map{|n| n.chr}
  def generate
    # outputs a random password with the initialized length
    ALL_CHARS
  end
end

p = PasswordGenerator.new
