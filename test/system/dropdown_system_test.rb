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

    # I'm going to come back to this later.
    # class TabKeyTest < DropdownSystemTest

    class ArrowDownKeyTest < DropdownSystemTest
      test "should be possible to open the menu with ArrowDown" do
        with_preview(:default)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.downArrow)

        assert_menu
        assert_menu_linked_with_button

        assert_menu_items count: 5
        assert_menu_linked_with_item get_items[0]
      end

      test "should not be possible to open the menu with the down button when the menu button is disabled" do
        with_preview(:disabled)
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.downArrow)

        assert_menu visible: false
      end

      test "should have no active menu items when there are no menu items at all" do
        with_preview(:empty)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.downArrow)

        assert_menu
        assert_no_active_menu_items
      end

      test "should be possible to use the down arrow to navigate the menu" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items
        assert_menu_items count: 3
        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.downArrow)
        assert_menu_linked_with_item items[1]

        button_safe_send_keys(items[1], keyboard.downArrow)
        assert_menu_linked_with_item items[2]

        # Should not wrap focus on current implementation.
        button_safe_send_keys(items[2], keyboard.downArrow)
        assert_menu_linked_with_item items[2]
      end

      test "should be possible to use down arrow to navigate the menu items and skip the first disabled one" do
        with_preview(:first_item_disabled)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items
        assert_menu_items count: 5
        assert_menu_linked_with_item items[1]

        button_safe_send_keys(items[1], keyboard.downArrow)
        assert_menu_linked_with_item items[2]
      end

      test "should be possible to use down arrow to navigate the menu items and jump to the first non disabled one" do
        with_preview(:multiple_start_items_disabled)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items
        assert_menu_items count: 6
        assert_menu_linked_with_item items[2]

        button_safe_send_keys(items[1], keyboard.downArrow)
        assert_menu_linked_with_item items[3]
      end

      test "can jump disabled menu items" do
        with_preview(:disabled_jump)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu_items count: 5
        items = get_items
        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.downArrow)
        assert_menu_linked_with_item items[2]
      end

      test "can jump disabled menu items (multiple)" do
        with_preview(:disabled_multiple_jump)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        assert_menu_items count: 6
        items = get_items
        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.downArrow)
        assert_menu_linked_with_item items[3]
      end
    end

    class ArrowUpKeyTest < DropdownSystemTest
      test "should be possible to open the menu with ArrowUp and the last menu item should be selected" do
        with_preview(:disabled_jump)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        assert_menu
        assert_menu_linked_with_button

        assert_menu_items count: 5
        assert_menu_linked_with_item get_items[4]
      end

      test "should not be possible to open the menu with the ArrowUp when the menu button is disabled" do
        with_preview(:disabled)
        assert_menu visible: false

        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        assert_menu visible: false
      end

      test "should have no active menu items when there are no menu items at all" do
        with_preview(:empty)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        assert_menu
        assert_no_active_menu_items
      end

      test "should be possible to use down arrow to navigate the menu items and skip the first disabled one" do
        with_preview(:default)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        items = get_items
        assert_menu_items count: 5
        assert_menu_linked_with_item items[3]

        button_safe_send_keys(items[1], keyboard.upArrow)
        assert_menu_linked_with_item items[2]
      end

      test "should not be possible to navigate up or down if there is only one non-disabled item" do
        with_preview(:one_active)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items
        assert_menu_items count: 3
        assert_menu_linked_with_item(items[1])

        button_safe_send_keys(items[1], keyboard.upArrow)
        assert_menu_linked_with_item(items[1])

        button_safe_send_keys(items[1], keyboard.downArrow)
        assert_menu_linked_with_item(items[1])
      end

      test "should be possible to navigate the menu with the up arrow" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        assert_menu
        assert_menu_linked_with_button

        items = get_items
        assert_menu_linked_with_item items[2]

        button_safe_send_keys(items[2], keyboard.upArrow)
        assert_menu_linked_with_item items[1]

        button_safe_send_keys(items[1], keyboard.upArrow)
        assert_menu_linked_with_item items[0]

        # Should not go up again because the menu is at the top.
        button_safe_send_keys(items[0], keyboard.upArrow)
        assert_menu_linked_with_item items[0]
      end
    end

    class EndKeyTest < DropdownSystemTest
      test "should be possible to use the end key to get the last menu item" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items

        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.end)
        assert_menu_linked_with_item items[2]
      end

      test "should be possible to use the end key to get the last non-disabled menu item" do
        with_preview(:default)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items

        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.end)
        assert_menu_linked_with_item items[3]
      end

      test "should be possible to use the end key to go to the first menu item if that is the only non-disabled item" do
        with_preview(:all_disabled_but_start)

        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.end)

        assert_menu_linked_with_item get_items[0]
      end

      test "should have not active menu items upon end key press if there are no non-disabled items" do
        with_preview(:all_items_disabled)

        get_menu_button.click
        assert_no_active_menu_items

        button_safe_send_keys(get_menu, keyboard.end)
        assert_no_active_menu_items
      end
    end

    class PageDownKeyTest < DropdownSystemTest
      test "should be possible to use the page down key to get the last menu item" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items

        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.pageDown)
        assert_menu_linked_with_item items[2]
      end

      test "should be possible to use the page down key to get the last non-disabled menu item" do
        with_preview(:default)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.enter)

        items = get_items

        assert_menu_linked_with_item items[0]

        button_safe_send_keys(items[0], keyboard.pageDown)
        assert_menu_linked_with_item items[3]
      end

      test "should be possible to use the page down key to go to the first menu item if that is the only non-disabled item" do
        with_preview(:all_disabled_but_start)

        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.pageDown)

        assert_menu_linked_with_item get_items[0]
      end

      test "should have not active menu items upon page down key press if there are no non-disabled items" do
        with_preview(:all_items_disabled)

        get_menu_button.click
        assert_no_active_menu_items

        button_safe_send_keys(get_menu, keyboard.pageDown)
        assert_no_active_menu_items
      end
    end

    class HomeKeyTest < DropdownSystemTest
      test "should be possible to use the home key to get the first menu item" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        items = get_items

        assert_menu_linked_with_item items[2]

        button_safe_send_keys(items[2], keyboard.home)
        assert_menu_linked_with_item items[0]
      end

      test "should be possible to use the home key to get the first non-disabled menu item" do
        with_preview(:first_item_disabled)

        assert_menu visible: false
        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.home)

        assert_menu_linked_with_item get_items[1]
      end

      test "should be possible to use the home key to go to the last menu item if that is the only non-disabled item" do
        with_preview(:all_disabled_but_end)

        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.home)

        assert_menu_linked_with_item get_items[2]
      end

      test "should have not active menu items upon home key press if there are no non-disabled items" do
        with_preview(:all_items_disabled)

        get_menu_button.click
        assert_no_active_menu_items

        button_safe_send_keys(get_menu, keyboard.home)
        assert_no_active_menu_items
      end
    end

    class PageUpKeyTest < DropdownSystemTest
      test "should be possible to use the page up key to get the first menu item" do
        with_preview(:user_menu_example)

        assert_menu visible: false
        button_safe_send_keys(get_menu_button, keyboard.upArrow)

        items = get_items

        assert_menu_linked_with_item items[2]

        button_safe_send_keys(items[2], keyboard.pageUp)
        assert_menu_linked_with_item items[0]
      end

      test "should be possible to use the page up key to get the first non-disabled menu item" do
        with_preview(:first_item_disabled)

        assert_menu visible: false
        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.pageUp)

        assert_menu_linked_with_item get_items[1]
      end

      test "should be possible to use the page up key to go to the last menu item if that is the only non-disabled item" do
        with_preview(:all_disabled_but_end)

        get_menu_button.click

        assert_no_active_menu_items
        button_safe_send_keys(get_menu, keyboard.pageUp)

        assert_menu_linked_with_item get_items[2]
      end

      test "should have not active menu items upon page up key press if there are no non-disabled items" do
        with_preview(:all_items_disabled)

        get_menu_button.click
        assert_no_active_menu_items

        button_safe_send_keys(get_menu, keyboard.pageUp)
        assert_no_active_menu_items
      end
    end

    class SearchTest < DropdownSystemTest
      test "should be possible to type a full word that has a perfect match" do
        with_preview(:default)

        get_menu_button.click
        items = get_items

        type_word(get_menu, "Cheese")
        assert_menu_linked_with_item items[1]

        type_word(items[1], "Eggs")
        assert_menu_linked_with_item items[0]

        type_word(items[0], "Milk")
        assert_menu_linked_with_item items[2]
      end

      test "should be able to type a partial of a word" do
        with_preview(:default)

        get_menu_button.click
        items = get_items

        type_word(get_menu, "Che")
        assert_menu_linked_with_item items[1]

        type_word(items[1], "Eg")
        assert_menu_linked_with_item items[0]

        type_word(items[0], "Mi")
        assert_menu_linked_with_item items[2]
      end

      # I don't love this test. Worth revisiting sometime. Testing some JS in Ruby is a pain
      test "should be possible to type words with spaces" do
        with_preview(:search_test)

        get_menu_button.click
        items = get_items

        type_word(get_menu_button, "Value B")
        assert_menu_linked_with_item items[1]

        type_word(items[1], "Value A")
        assert_menu_linked_with_item items[0]

        type_word(items[0], "Value C")
        assert_menu_linked_with_item items[2]
      end

      test "should not be possible to search for a disabled item" do
        with_preview(:default)

        button_safe_send_keys(get_menu_button, keyboard.enter)
        items = get_items

        assert_menu_linked_with_item items[0]
        type_word(items[0], "Bana")

        assert_menu_linked_with_item items[0]
      end

      test "should be possible to search for a word (case-insensitive)" do
        with_preview(:default)

        get_menu_button.click
        items = get_items

        type_word(get_menu, "che")
        assert_menu_linked_with_item items[1]

        type_word(items[1], "eg")
        assert_menu_linked_with_item items[0]

        type_word(items[0], "mi")
        assert_menu_linked_with_item items[2]
      end

      test "should be possible to search for the next occurence" do
        with_preview(:search_test)

        get_menu_button.click
        items = get_items

        type_word get_menu, "Value B"
        assert_menu_linked_with_item items[1]

        type_word get_menu, "Value B"
        assert_menu_linked_with_item items[3]
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
