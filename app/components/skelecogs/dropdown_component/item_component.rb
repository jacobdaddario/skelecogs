module Skelecogs
  class DropdownComponent
    class ItemComponent < ApplicationComponent
      def call
        content_tag tag_type, content, {class: classes, role: "menuitem", disabled: disabled, data: {action: "click->dropdown#afterSelection", "dropdown-target": "item"}}
      end

      private

      def default_tag
        :div
      end
    end
  end
end
