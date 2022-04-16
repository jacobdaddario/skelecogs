require "application_system_test_case"
require "utils/dropdown_helpers"

class DropdownSystemTest < ApplicationSystemTestCase
  include DropdownHelpers

  class SafeguardsTest < DropdownSystemTest
    # Can't check this because of current view component code
    # test "should not render children without parent dropdown"

    test "should render a dropdown" do
      with_preview(:default)

      assert_menu visible: false
      assert_menu_button
    end
  end

  class MouseInteractionsTest < DropdownSystemTest
    test "should be possible to open a menu on click" do
      with_preview(:default)

      assert_menu visible: false
      assert_menu_button

      get_menu_button.click

      assert_menu
      assert_menu_items count: 4
      # Unfortunately, I'm unsure if this is possible
      # assert_menu_linked_with_button
    end

    test "should not be possible to open a menu on right-click" do
      with_preview(:default)

      assert_menu visible: false
      assert_menu_button

      get_menu_button.right_click

      assert_menu visible: false
      assert_menu_items visible: false
    end

    test "should not be possible to open a menu on click when the button is disabled" do
      with_preview(:disabled)

      assert_menu visible: false
      assert_menu_button

      get_menu_button.click

      assert_menu visible: false
      assert_menu_items visible: false
    end

    test "should be possible to close a menu on click" do
      with_preview(:default)
      button = get_menu_button
      button.click
      assert_menu

      button.click
      assert_menu visible: false
    end

    test "should do nothing when clicking outside of the menu" do
      with_preview(:default)

      assert_menu visible: false
      click_outside_menu
      assert_menu visible: false
    end
  end
end
