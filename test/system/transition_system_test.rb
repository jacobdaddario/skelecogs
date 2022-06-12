require "application_system_test_case"
require_relative "../utils/transition_helpers"

class TransitionSystemTest < ApplicationSystemTestCase
  include TransitionHelpers

  class SetupAPITest < TransitionSystemTest
    class ShallowTest < SetupAPITest
      test "should be hidden when show is false" do
        with_preview(:hidden)

        assert_transition visible: false
      end
    end

    class NestedTest < SetupAPITest
      # test "should yell at us when we forget to wrap the `<Transition.child />` in a parent <Transition /> component" do

      test "should be possible to render a transition child without children" do
        with_preview(:child)

        assert_selector "#transition"
      end

      test "should be possible to nest multiple child components" do
        with_preview(:multiple_children)

        assert_text "Sidebar"
        assert_text "Content"
      end

      test "should be possible to change the underlying DOM tag of the Transition.Child elements" do
        with_preview(:multiple_children)

        assert_selector("aside")
        assert_selector("section")
      end

      test "should be possible to change the underlying DOM tag of the Transition component and Child components" do
        with_preview(:multiple_children)

        assert_selector("article")
        assert_selector("aside")
        assert_selector("section")
      end
    end
  end

  class TransitionsTest < TransitionSystemTest
    class ShallowTransitionsTest < TransitionSystemTest

    end
  end
end
