module Skelecogs
  class ApplicationComponent < ViewComponent::Base
    def initialize(**opts)
      @classes = opts[:class]
    end
  end
end
