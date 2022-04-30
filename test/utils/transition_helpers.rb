module TransitionHelpers
  def build_fragment(fragment)
    Nokogiri::HTML.fragment(fragment.chomp)
  end

  def assert_equal_fragments(expected, result)
    assert_equal expected.to_s, result.to_s
  end
end
