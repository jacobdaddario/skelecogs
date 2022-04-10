module Skelecogs
  class DropdownComponent
    class ItemsComponent < ApplicationComponent
      def call
        content_tag :div, content, {class: @classes, data: {"dropdown-target": "itemsContainer"}}
      end
    end
  end
end
