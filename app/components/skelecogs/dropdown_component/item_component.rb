module Skelecogs
  class DropdownComponent
    class ItemComponent < ApplicationComponent
      def call
        tag.send(tag_type, **html_options, role: "menuitem", data: {action: "click->dropdown#afterSelection", "dropdown-target": "item"}) { content }
      end

      private

      def default_tag
        :div
      end
    end
  end
end
