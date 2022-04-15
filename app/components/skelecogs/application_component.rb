module Skelecogs
  class ApplicationComponent < ViewComponent::Base
    def initialize(**opts)
      @classes = opts[:class]
      @as = opts[:as]

      initialization_hook(opts)
    end

    def tag_type
      @as || default_tag
    end

    def initialization_hook(opts)
    end

    private

    def default_tag
      raise NotImplementedError.new "The component tried to fall back to its default tag type, but one was not defined."
    end
  end
end
