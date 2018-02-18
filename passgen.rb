# CLI password generator in Ruby.

require 'optionparser'

class PasswordGenerator
  attr_accessor :length
  ALL_CHARS = (32).upto(126).map{|n| n.chr} # full char space
  ALPHANUMERIC = "a".upto("z").to_a
    .concat("A".upto("Z").to_a)
    .concat("0".upto("9").to_a)
  def generate
    # outputs a random password with the initialized length
    ALPHANUMERIC
  end
end

p = PasswordGenerator.new
p p.generate
