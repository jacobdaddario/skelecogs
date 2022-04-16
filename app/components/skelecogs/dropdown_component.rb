module Skelecogs
  class DropdownComponent < ApplicationComponent
    attr_reader :reveal_classes

    renders_one :button, Skelecogs::DropdownComponent::ButtonComponent
    renders_one :items_container, Skelecogs::DropdownComponent::ItemsComponent

    def initialization_hook(opts)
      @reveal_classes = opts[:reveal_with]
    end

    private

    def default_tag
      :div
    end
  end
end
