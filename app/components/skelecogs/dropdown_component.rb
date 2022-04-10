module Skelecogs
  class DropdownComponent < ApplicationComponent
    renders_one :button, Skelecogs::DropdownComponent::ButtonComponent
    renders_one :items_container, Skelecogs::DropdownComponent::ItemsComponent

    def initialization_hook(opts)
      @reveal_classes = opts[:reveal_with]
    end
  end
end
