module Skelecogs
  class ApplicationComponent < ViewComponent::Base
    def initialize(**opts)
      @classes = opts[:class]

      initialization_hook(opts)
    end

    def initialization_hook(opts)
    end
  end
end
