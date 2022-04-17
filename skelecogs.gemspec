require_relative "lib/skelecogs/version"

Gem::Specification.new do |spec|
  spec.name        = "skelecogs"
  spec.version     = Skelecogs::VERSION
  spec.authors     = ["Jacob Daddario\n"]
  spec.email       = ["jacob.d@hey.com"]
  spec.homepage    = "https://github.com"
  spec.summary     = "Summary of Skelecogs."
  spec.description = "Description of Skelecogs."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com"
  spec.metadata["changelog_uri"] = "https://github.com"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.2.3"
  spec.add_runtime_dependency     "view_component", [">= 2.0.0", "< 3.0"]
  spec.add_runtime_dependency     "turbo-rails", "~> 1.0.1"
  spec.add_runtime_dependency     "stimulus-rails", "~> 1.0.4"

  spec.add_development_dependency "capybara", "~> 3"
  spec.add_development_dependency "cuprite", "= 0.13"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "parallel_tests", "~> 3.8"
end
