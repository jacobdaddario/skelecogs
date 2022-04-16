module AccessabilityHelpers
  def get_active_element
    page.driver.evaluate_script("document.activeElement")
  end

  def assert_active_element(element)
    assert_equal element.native, get_active_element
  end
end
