# frozen_string_literal: true

require "test_helper"

class TransitionComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::TagHelper

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
end
