module Skelecogs
  class Engine < ::Rails::Engine
    require "turbo-rails"
    require "stimulus-rails"
    require "view_component/engine"
  end
end
