module Skelecogs
  class TestComponentPreview < ViewComponent::Preview
    def with_default_title
      render Skelecogs::TestComponent.new
    end
  end
end
