module Ferrum
  class Page
    module Animation
      def animations
        @animations.values
      end

      def seek_animations(animations:, time:)
        command("Animation.seekAnimations", animations: animations, currentTime: time)
      end

      private

        def subscribe_created_animation
          on("Animation.animationCreated") do |params|
            animation_id = params.values_at("id")
            @animations[animation_id] = ::Ferrum::Animation.new(id: animation_id)
          end
        end
    end
  end

  class Animation
    attr_accessor :id

    def initialize(id:)
      @id = id
    end
  end
end
