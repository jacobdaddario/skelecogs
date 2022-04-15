module Skelecogs
  class DropdownComponent
    class ItemsComponent < ApplicationComponent
      renders_many :items, Skelecogs::DropdownComponent::ItemComponent

      private

      def default_tag
        :div
      end
    end
  end
end
