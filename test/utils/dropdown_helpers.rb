module DropdownHelpers
  def assert_menu(visible: true)
    visible ? assert_selector("div[role='menu']") : assert_selector("div[role='menu']", count: 0)
  end

  def assert_menu_button(visible: true)
    visible ? assert_selector("button[role='button']") : assert_selector("button[role='button']", count: 0)
  end

  def assert_menu_items(visible: true, count: 1)
    visible ? assert_selector("div[role='menuitem']", count: count) : assert_selector("div[role='menuitem']", count: 0)
  end

  def assert_menu_linked_with_button
    assert_selector "button[role='button'][aria-controls='skelecogs-menu-items-1']"
    assert_selector "div[role='menu'][aria-labelledby='skelecogs-menu-button-1']"
  end

  def get_menus
    all "div[role='menu']"
  end

  def get_menu_button
    find "button[role='button']"
  end

  def get_menu_buttons
    all "button[role='button']"
  end

  def get_items
    all "items[role='button']"
  end

  def click_outside_menu
    find("#alternate-target").click
  end
end
