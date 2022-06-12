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
      test "should be possible to render a transition child without children" do
        with_preview(:child)

        assert_selector "#transition"
      end
    end
  end
end
