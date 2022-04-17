module Skelecogs
  class ApplicationComponent < ViewComponent::Base
    attr_reader :tag_type, :html_options

    def initialize(**opts)
      @tag_type = opts.delete(:as) || default_tag
      @html_options = opts

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
