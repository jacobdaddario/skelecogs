module Skelecogs
  class DropdownComponent
    class ButtonComponent < ApplicationComponent
      def call
        content_tag :button, content, {class: @classes, role: "button", data: {"dropdown-target": "button", action: "dropdown#toggle"}}
      end
    end
  end
end
