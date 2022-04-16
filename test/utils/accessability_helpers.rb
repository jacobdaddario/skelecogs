module AccessabilityHelpers
  def get_active_element
    page.driver.evaluate_script("document.activeElement")
  end

  def assert_active_element(element, mode: :strict)
    case mode
    when :strict
      assert_equal element.native, get_active_element, "#{element} was not the active element"
    when :loose
      assert (element.native == get_active_element) || element[:outerHTML].contains(:elemtn)
  end
end
