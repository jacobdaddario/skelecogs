# frozen_string_literal: true

require "test_helper"

class DropdownComponentTest < ViewComponent::TestCase
  class RenderingCompositionTest < DropdownComponentTest
    test "should be able to conditionally render classes" do
      boolean = true

      render_inline Skelecogs::DropdownComponent.new do |c|
        c.button class: boolean ? "true" : "false"
        c.items_container do |container|
          container.item
        end
      end

      assert_selector "button[role='button'].true"

      boolean = false

      render_inline Skelecogs::DropdownComponent.new do |c|
        c.button class: boolean ? "true" : "false"
        c.items_container do |container|
          container.item
        end
      end

      assert_selector "button[role='button'].false"
    end

    test "should be possible to swap a menu item with a button for example" do
      render_inline Skelecogs::DropdownComponent.new do |c|
        c.button
        c.items_container do |container|
          container.item as: :button
          container.item as: :button
          container.item as: :button
        end
      end

      assert_selector "button[role='menuitem']", count: 3
    end
  end
end
