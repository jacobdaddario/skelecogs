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
end
