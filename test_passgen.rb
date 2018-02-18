require 'minitest/autorun'
require './passgen'

class TestPasswordGenerator < Minitest::Test

  def setup
    @passgen = PasswordGenerator.new(:length => 10, :count => 1)
  end

  def test_password_length_is_10_on_default
    assert_equal 10, @passgen.generate.length
  end

  def test_alphanumeric_only_on_default
    non_alpha = ALPHANUMERIC - ALL_CHARS
    assert_equal false, @passgen.generate.split("").include?(non_alpha)
  end
end
