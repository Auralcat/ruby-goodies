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
    # Split the paragraphs and count them
    assert_equal(output.split("\n\n").length, 4)
  end

  # Atomic paragraph testing
  single_paragraph = LoremGenerator.new(:paragraphs => 1)

  # Paragraph checking
  def test_short_paragraphs_have_between_25_and_30_words
    cond = single_paragraph.output.split(" ").length <= 30 and single_paragraph.output.split(" ") >= 25
    assert_equal(single_paragraph.output.split(" ").length )
  end

  def test_medium_paragraphs_have_between_50_and_60_words
  end

  def test_long_paragraphs_have_between_75_and_90_words
  end


end
