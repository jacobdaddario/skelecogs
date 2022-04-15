require "application_system_test_case"

class DropdownSystemTest < ApplicationSystemTestCase
  class SafeguardsTest < DropdownSystemTest
    # Can't check this because of current view component code
    # test "should not render children without parent dropdown"

    test "should render a dropdown" do
      with_preview(:default)

      assert_selector "div[role='menu']"
      assert_selector "button[role='button']"
    end
  end

  class MouseInteractionsTest < DropdownSystemTest

  end
end
