module DropdownHelpers
  def assert_menu(visible: true)
    visible ? assert_selector("div[role='menu']") : assert_selector("div[role='menu']", count: 0)
  end

  def assert_menu_button(visible: true)
    visible ? assert_selector("button[role='button']") : assert_selector("button[role='button']", count: 0)
  end

  def assert_menu_items(visible: true, count: 1)
    visible ? assert_selector("a[role='menuitem']", count: count) : assert_selector("a[role='menuitem']", count: 0)
  end

  def assert_menu_linked_with_button
    assert_selector "button[role='button'][aria-controls='skelecogs-menu-items-1']"
    assert_selector "div[role='menu'][aria-labelledby='skelecogs-menu-button-1']"
  end

  def assert_menu_linked_with_item(item)
    assert_equal item[:id], get_menu["aria-activedescendant"]
  end

  def assert_no_active_menu_items
    assert_nil get_menu["aria-activedescendant"]
  end

  def get_menu
    find "div[role='menu']", match: :first
  end

  def get_menus
    all "div[role='menu']"
  end

  def get_menu_button
    find "button[role='button']", match: :first
  end

  def get_menu_buttons
    all "button[role='button']"
  end

  def get_items
    all "[data-dropdown-target='item']"
  end

  def click_outside_menu
    find("#alternate-target").click
  end

  def hover_outside_menu
    find("#alternate-target").hover
  end
end
