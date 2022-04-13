module Skelecogs
  class DropdownComponent
    class ItemsComponent < ApplicationComponent
      renders_many :items, Skelecogs::DropdownComponent::ItemComponent
    end
  end
end
