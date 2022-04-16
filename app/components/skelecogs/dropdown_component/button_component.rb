module Skelecogs
  class DropdownComponent
    class ButtonComponent < ApplicationComponent
      def call
        content_tag tag_type, content, {class: classes, role: "button", disabled: disabled, data: {"dropdown-target": "button", action: "dropdown#toggle"}}
      end

      private

      def default_tag
        :button
      end
    end
  end
end
