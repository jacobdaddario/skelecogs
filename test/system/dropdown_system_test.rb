require "application_system_test_case"

class DropdownSystemTest < ApplicationSystemTestCase
  test "can expand dropdown" do
    with_preview(:default)

    assert_no_text "Apples"
    click_on "Groceries"
    assert_text "Apples"
  end
end
