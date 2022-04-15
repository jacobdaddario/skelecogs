module Skelecogs
  class DropdownComponent
    class ItemComponent < ApplicationComponent
      def call
        content_tag tag_type, content, {class: @classes, role: "menuitem", data: {"dropdown-target": "item"}}
      end

      private

      def default_tag
        :div
      end
    end
  end
end
