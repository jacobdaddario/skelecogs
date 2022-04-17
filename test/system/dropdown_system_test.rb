require "application_system_test_case"
require "utils/dropdown_helpers"
require "utils/accessability_helpers"
require "utils/interactions"

class DropdownSystemTest < ApplicationSystemTestCase
  include DropdownHelpers, AccessabilityHelpers, Interactions

  class SafeguardsTest < DropdownSystemTest
    # Can't check this because of current view component code
    # test "should not render children without parent dropdown"

    test "should render a dropdown" do
      with_preview(:default)

      assert_menu visible: false
      assert_menu_button
    end
  end

  class KeyboardInteractionsTest < DropdownSystemTest
    class EnterKeyTest < DropdownSystemTest
      test "should be possible to open a menu with the enter button" do
        with_preview(:default)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, :enter)

        assert_menu
        assert_menu_items count: 5
      end

      test "should not be possible to open a menu button with enter when the button is disabled" do
        with_preview(:disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, :enter)

        assert_menu visible: false
        assert_menu_items visible: false
      end

      # Can't do this until figure out id problem
      # test "should have no active menu items when there are no menu items"

      test "should focus the first menu item when opening with enter" do
        with_preview(:default)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, :enter)

        assert_active_element(get_items[0])
      end
    end
  end

  class MouseInteractionsTest < DropdownSystemTest
    test "should be possible to open a menu on click" do
      with_preview(:default)

      assert_menu visible: false
      assert_menu_button

      get_menu_button.click

      assert_menu
      assert_menu_items count: 5
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

    test "should be able to hover an item and make it active" do
      with_preview(:default)

      get_menu_button.click
      items = get_items

      items[0].hover
      assert_menu_linked_with_item(items[0])

      items[1].hover
      assert_menu_linked_with_item(items[1])

      items[2].hover
      assert_menu_linked_with_item(items[2])
    end

    test "should not change active element when mousing over an already active element" do
      with_preview(:default)

      get_menu_button.click
      items = get_items

      items[1].hover
      assert_menu_linked_with_item(items[1])

      items[1].hover
      assert_menu_linked_with_item(items[1]) end

    test "should not mark disabled items as active" do
      with_preview(:default)

      get_menu_button.click
      items = get_items

      items[4].hover
      assert_no_active_menu_items
    end

    test "should be possible to mouse leave an item and make it inactive" do
      with_preview(:default)

      get_menu_button.click
      items = get_items

      items[1].hover
      assert_menu_linked_with_item(items[1])

      hover_outside_menu
      assert_no_active_menu_items
    end

    test "nothing should happen when mouse leaving a disabled element" do
      with_preview(:default)

      get_menu_button.click
      items = get_items

      items[4].hover
      assert_no_active_menu_items

      hover_outside_menu
      assert_no_active_menu_items
    end

    test "clicking a menu items should close the menu" do
      with_preview(:default)

      get_menu_button.click
      assert_menu

      item = get_items[0]
      item_text = item.text
      item.click

      assert_menu visible: false
      assert_equal page.driver.browser.current_url.split("#")[1], item_text
    end

    # Need to investigate more into how they get disabled to work on anchor tags to
    # figure out what's going on with this.
    # test "clicking a disabled menu does not close the menu"

    # test "should not be possible to focus a menu item which is disabled"

    # test "should  not be possilbe to activate a disabled item"

    test "should be possible to focus an element, making it active" do
      with_preview(:default)

      get_menu_button.click
      assert_menu

      items = get_items
      assert_no_active_menu_items

      items[0].trigger("focus")
      assert_menu_linked_with_item(items[0])

      items[0].trigger("blur")
      assert_no_active_menu_items
    end
  end
end
