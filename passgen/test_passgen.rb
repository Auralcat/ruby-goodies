require 'minitest/autorun'
require './passgen'

class TestPasswordGenerator < Minitest::Test

  def setup
    @passgen = PasswordGenerator.new("length" => 10, "count" => 1)
  end

  def test_password_length_is_10_on_default
    assert_equal 10, @passgen.generate.length
  end

  def test_password_has_all_chars_on_default
    assert_equal true, @passgen.all_chars_output?
  end

  def test_outputs_emoji_password_with_option_e
    # We need a new class with emoji enabled
    emoji_passgen = PasswordGenerator.new("length" => 10, "count" => 1,
                                          "emoji" => true)
    assert_equal true, emoji_passgen.emoji_output?
  end
end
