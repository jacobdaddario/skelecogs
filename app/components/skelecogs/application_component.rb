module Skelecogs
  class ApplicationComponent < ViewComponent::Base
    attr_reader :classes, :id, :disabled, :tag_type

    def initialize(**opts)
      @classes = opts[:class]
      @id = opts[:id]
      @tag_type = opts[:as] || default_tag
      @disabled = opts[:disabled]

      initialization_hook(opts)
    end

    def initialization_hook(opts)
    end

    private

    def default_tag
      raise NotImplementedError.new "The component tried to fall back to its default tag type, but one was not defined."
    end
  end
end
