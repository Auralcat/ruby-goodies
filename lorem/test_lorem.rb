require 'minitest/autorun'
require './passgen'

class TestLoremGenerator < Minitest::Test

  def setup
    @lorem = LoremGenerator.new()
  end

  # Testing default output
  def test_output_starts_with_lorem_ipsum_on_default
    assert_equal(/^Lorem ipsum/.match(@lorem), true)
  end

  def test_output_returns_4_medium_paragraphs_on_default
  end

  # Paragraph checking
  def test_short_paragraphs_have_between_25_and_30_words
  end

  def test_medium_paragraphs_have_between_50_and_60_words
  end

  def test_long_paragraphs_have_between_75_and_90_words
  end


end
