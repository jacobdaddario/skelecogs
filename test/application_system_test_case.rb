require "test_helper"
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    **{
      # Enable debugging capabilities
      inspector: true,
      headless: !ENV["HEADLESS"].in?(%w[n 0 no false])
    }
  )
end

Capybara.default_driver = Capybara.javascript_driver = :cuprite

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  def with_preview(preview_name)
    component_name = self.class.name.gsub("Test", "").gsub("Integration", "")
    component_uri = component_name.underscore

    visit("/rails/view_components/skelecogs/#{component_uri}/#{preview_name}")
  end
end
