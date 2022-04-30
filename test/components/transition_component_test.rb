require "test_helper"
require "utils/transition_helpers"

class TransitionComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::TagHelper, TransitionHelpers

  test "should render without crashing" do
    render_inline Skelecogs::TransitionComponent.new(show: true) do |c|
      tag.div "Children", class: "hello"
    end

    assert_text "Children"
  end

  test "should be possible to render a transition without children" do
    render_inline Skelecogs::TransitionComponent.new(show: true, class: "transition")

    assert_selector ".transition"
  end

  test "should throw an argument error when the required show argument is not provided" do
    assert_raise ArgumentError do
      render_inline Skelecogs::TransitionComponent.new do |c|
        tag.div "Children", class: "hello"
      end
    end
  end

  class SetupAPITest < TransitionComponentTest
    class ShallowTest < SetupAPITest
      test "should render a div with content by default" do
        result = render_inline Skelecogs::TransitionComponent.new(show: true) do |c|
          "Children"
        end

        expected = build_fragment(<<~FRAGMENT
          <div>
            Children
          </div>
          FRAGMENT
        )

        assert_equal_fragments expected, result
      end

      test "should pass through html options" do
        result = render_inline Skelecogs::TransitionComponent.new(show: true, class: "text-blue-500", id: "root") do |c|
          "Children"
        end

        assert_selector ".text-blue-500#root"
      end
    end
  end
end
