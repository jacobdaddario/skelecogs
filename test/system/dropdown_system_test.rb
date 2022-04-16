require "application_system_test_case"
require "utils/dropdown_helpers"
require "utils/accessability_helpers"

class DropdownSystemTest < ApplicationSystemTestCase
  include DropdownHelpers, AccessabilityHelpers

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

    test "should close the menu when clicking outside of the menu" do
      with_preview(:default)
      button = get_menu_button

      button.click
      assert_menu

      click_outside_menu
      assert_menu visible: false

      assert_active_element button
    end

    test "should close menu if the menu button is clicked again" do
      with_preview(:default)
      button = get_menu_button

      button.click
      assert_menu

      button.click
      assert_menu visible: false

      assert_active_element button
    end

    test "should be able to click from menu button to menu button, cycling between the different menus" do
      with_preview(:multiple)
      button1, button2 = *get_menu_buttons

      button1.click
      assert_text "Red"
      assert_no_text "SM"

      button2.click
      assert_text "SM"
      assert_no_text "Red"
    end

    test "should be possible to click from an open menu to another focusable element, closing the menu and focusing the correct element" do
      with_preview(:multiple)

      get_menu_button.click
      assert_menu

      filter_button = find_button "Filter"
      filter_button.click
      assert_menu visible: false

      assert_active_element(filter_button)
    end
  end
end
