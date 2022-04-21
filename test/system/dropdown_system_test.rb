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

        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu
        assert_menu_items count: 5
      end

      test "should not be possible to open a menu button with enter when the button is disabled" do
        with_preview(:disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu visible: false
        assert_menu_items visible: false
      end

      test "should have no active menu items when there are no menu items" do
        with_preview(:empty)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu
        assert_no_active_menu_items
      end

      test "should focus the first non-disabled item when opening with enter" do
        with_preview(:first_item_disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu_linked_with_item(get_items[1])
      end

      test "should focus the first non-disabled item when opening with enter (jump over multiple disabled items)" do
        with_preview(:multiple_start_items_disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu_linked_with_item(get_items[2])
      end

      test "should have no active menu items when opening menu with enter and there are no non-disabled elements" do
        with_preview(:all_items_disabled)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_no_active_menu_items
      end

      test "should be possible to close the menu with enter when there are no active menu items" do
        with_preview(:default)

        assert_menu visible: false
        get_menu_button.click
        assert_menu

        button_safe_send_keys(get_menu, keyboard.enter)

        assert_menu visible: false
        assert_active_element(get_menu_button)
      end

      test "should be possible to invoke the active menu item and close the menu with Enter" do
        with_preview(:default)

        assert_menu visible: false
        get_menu_button.click
        assert_menu

        item = get_items[0]
        item_text = item.text
        item.hover
        button_safe_send_keys(item, keyboard.enter)

        assert_menu visible: false
        assert_active_element(get_menu_button)
        assert_equal page.driver.browser.current_url.split("#")[1], item_text
      end

      test "should be possible to use a button as a menu item and to invoke it with enter" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        get_menu_button.click

        assert_menu
        item_button = get_items[2]
        item_text = "logout"

        button_safe_send_keys(item_button, keyboard.enter)
        assert_menu visible: false
        assert_equal page.driver.browser.current_url.split("#")[1], item_text
      end
    end

    class SpaceKeyTest < DropdownSystemTest
      test "should be possible to open a menu with the space button" do
        with_preview(:default)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu
        assert_menu_items count: 5
      end

      test "should not be possible to open a menu button with space when the button is disabled" do
        with_preview(:disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu visible: false
        assert_menu_items visible: false
      end

      test "should have no active menu items when there are no menu items" do
        with_preview(:empty)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu
        assert_no_active_menu_items
      end

      test "should focus the first non-disabled item when opening with space" do
        with_preview(:first_item_disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu_linked_with_item(get_items[1])
      end

      test "should focus the first non-disabled item when opening with space (jump over multiple disabled items)" do
        with_preview(:multiple_start_items_disabled)
        assert_menu_button
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu_linked_with_item(get_items[2])
      end

      test "should have no active menu items when opening menu with space and there are no non-disabled elements" do
        with_preview(:all_items_disabled)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_no_active_menu_items
      end

      test "should be possible to close the menu with space when there are no active menu items" do
        with_preview(:default)

        assert_menu visible: false
        get_menu_button.click
        assert_menu

        button_safe_send_keys(get_menu, keyboard.space)

        assert_menu visible: false
        assert_active_element(get_menu_button)
      end

      test "should be possible to invoke the active menu item and close the menu with Space" do
        with_preview(:default)

        assert_menu visible: false
        get_menu_button.click
        assert_menu

        item = get_items[0]
        item_text = item.text
        item.hover
        button_safe_send_keys(item, keyboard.space)

        assert_menu visible: false
        assert_active_element(get_menu_button)
        assert_equal page.driver.browser.current_url.split("#")[1], item_text
      end
    end

    class EscapeKeyTest < DropdownSystemTest
      test "should be possible to close an open menu with escape" do
        with_preview(:default)

        button_safe_send_keys(get_menu_button, keyboard.space)

        assert_menu
        assert_menu_items count: 5

        button_safe_send_keys(get_menu, keyboard.escape)

        assert_menu visible: false
        assert_menu_items visible: false
        assert_active_element(get_menu_button)
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
      assert_menu_linked_with_item(items[1])
    end

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

    test "clicking a disabled menu does not close the menu" do
      with_preview(:default)

      get_menu_button.click
      assert_menu

      items = get_items
      items[4].click

      assert_menu
      assert_nil page.driver.browser.current_url.split("#")[1]
    end

    test "should not be possible to focus a menu item which is disabled" do
      with_preview(:default)

      get_menu_button.click
      assert_menu

      items = get_items
      items[4].execute_script("this.focus()")

      assert_no_active_menu_items
    end

    # I don't know how to do this without adding pointer-events none, but that's not headless
    # test "should not be possible to activate a disabled item" do
    #   with_preview(:button)

    #   get_menu_button.click
    #   assert_menu

    #   items = get_items

    #   items[3].click
    #   assert_menu
    #   assert_nil page.driver.browser.current_url.split("#")[1]

    #   items[4].click
    #   assert_menu
    #   assert_nil page.driver.browser.current_url.split("#")[1]
    # end

    # I actually hate how this works. I don't completely understand
    # what's going on with these stupid disabled components.
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
