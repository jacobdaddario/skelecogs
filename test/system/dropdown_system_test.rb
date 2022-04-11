require "application_system_test_case"

class DropdownSystemTest < ApplicationSystemTestCase
  test "can expand dropdown" do
    with_preview(:default)

    assert_no_text "Apples"
    click_on "Groceries"
    assert_text "Apples"
  end

  test "clicking out of the dropdown closes it" do
    with_preview(:default)

    click_on "Groceries"
    assert_text "Apples"

    find("#alternate-target").click
    assert_no_text "Apples"
  end

  test "escape regardless of focus closes the menu" do
    with_preview(:default)

    click_on "Groceries"
    assert_text "Apples"

    find("#alternate-target").send_keys(:escape)
    assert_no_text "Apples"
  end

  test "menu does not open when prompted with keys when the button is not focused" do
    with_preview(:default)

    element = find("#alternate-target")

    assert_no_text "Apples"
    element.send_keys(:enter)
    assert_no_text "Apples"

    assert_no_text "Apples"
    element.send_keys(:space)
    assert_no_text "Apples"
  end
end
