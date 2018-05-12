require 'minitest/autorun'

# Helper functions

# Test class
class TestLoremGenerator < Minitest::Test
  def test_get_html_source_returns_a_string
    assert_equal get_html_source().class, String
  end
end
