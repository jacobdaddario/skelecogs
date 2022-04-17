module Skelecogs
  class DropdownComponent
    class ItemComponent < ApplicationComponent
      def call
        tag.send(tag_type, **html_options, role: "menuitem", data: {controller: "prefixed-id", action: "click->dropdown#afterSelection mouseenter->dropdown#setActive mouseleave->dropdown#removeActive focus->dropdown#setActive blur->dropdown#removeActive", "dropdown-target": "item", "prefixed-id-prefix-value": "dropdown-menu-item"}) { content }
      end

      private

      def default_tag
        :div
      end
    end
  end
end
