require 'minitest/autorun'
require './lorem'

# Helper functions
class String
  def count_words
    split(' ').length
  end

  def word_count_in_range?(start, stop)
    count_words <= stop && count_words >= start
  end
end

# Test class
class TestLoremGenerator < Minitest::Test
  def setup
    @lorem = LoremGenerator.new({ paragraphs: 4 },
                                { lorem_ipsum: true })
    @single_paragraph = LoremGenerator.new({ paragraphs: 1 },
                                           { lorem_ipsum: true })
  end

  def test_output_returns_4_medium_paragraphs_on_default
    # Split the paragraphs and count them
    assert_equal(@lorem.generate.split("\n").length, 4)
  end

  def test_output_returns_a_string
    assert_equal(@lorem.generate.is_a?(String), true)
  end

  # Paragraph checking
  def test_short_paragraphs_have_between_25_and_30_words
    assert_equal(@single_paragraph.generate.word_count_in_range?(25, 30), true)
  end

  def test_medium_paragraphs_have_between_50_and_60_words
    assert_equal(@single_paragraph.generate.word_count_in_range?(50, 60), true)
  end

  def test_long_paragraphs_have_between_75_and_90_words
    assert_equal(@single_paragraph.generate.word_count_in_range?(75, 90), true)
  end
end
