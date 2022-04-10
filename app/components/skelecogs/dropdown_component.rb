module Skelecogs
  class DropdownComponent < ApplicationComponent
    renders_one :button, Skelecogs::DropdownComponent::ButtonComponent
    renders_one :items_container, Skelecogs::DropdownComponent::ItemsComponent
  end
end
