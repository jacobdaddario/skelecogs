module Skelecogs
  class DropdownComponent
    class ButtonComponent < ApplicationComponent
      def call
        tag.send(tag_type, **html_options, role: "button", data: {"dropdown-target": "button", action: "dropdown#toggle"}) { content }
      end

      private

      def default_tag
        :button
      end
    end
  end
end
