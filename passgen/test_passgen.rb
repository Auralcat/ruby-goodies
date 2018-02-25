require 'minitest/autorun'
require './passgen'

class TestPasswordGenerator < Minitest::Test

  def setup
    @passgen = PasswordGenerator.new(:length => 10, :count => 1)
  end

  def test_password_length_is_10_on_default
    assert_equal 10, @passgen.generate.length
  end

  def test_password_has_all_chars_on_default
    assert_equal true, @passgen.generate.match(/\A[a-zA-z0-9]*\z/).nil?
  end
end
