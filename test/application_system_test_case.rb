require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400], options: { inspector: true, headless: !ENV["HEADLESS"].in?(%w[n 0 no false])}

  def with_preview(preview_name)
    component_name = self.class.name.gsub("Test", "").gsub("Integration", "").gsub("System", "Component")
    component_uri = component_name.underscore

    visit("/rails/view_components/skelecogs/#{component_uri}/#{preview_name}")
  end
end
