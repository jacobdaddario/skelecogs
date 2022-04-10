module Skelecogs
  class Engine < ::Rails::Engine
    require "turbo-rails"
    require "stimulus-rails"
    require "view_component"

    initializer "skelecogs.assets.precompile" do |app|
      app.config.assets.precompile << "assets/builds/application.js"
    end
  end
end
