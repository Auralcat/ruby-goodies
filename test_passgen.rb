require 'minitest/autorun'
require './passgen'

class TestPasswordGenerator < Minitest::Test

  def test_password_length_is_10_on_default
    passgen = PasswordGenerator.new({:length => 10})
    assert_equal 10, passgen.generate.length
  end

end
