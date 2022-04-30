module Skelecogs
  class TransitionComponent < ApplicationComponent
    def initialization_hook(opts)
      @visible = opts[:show]

      if @visible.nil?
        throw ArgumentError.new("Show is a required input of transition components.")
      end
    end

    private

    def default_tag
      :div
    end
  end
end
