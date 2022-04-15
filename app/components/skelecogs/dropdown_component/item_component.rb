module Skelecogs
  class DropdownComponent
    class ItemComponent < ApplicationComponent
      def call
        content_tag :div, content, {class: @classes, role: "menuitem", data: {"dropdown-target": "item"}}
      end
    end
  end
end
