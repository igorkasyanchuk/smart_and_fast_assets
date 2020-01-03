$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "smart_and_fast_assets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "smart_and_fast_assets"
  spec.version     = SmartAndFastAssets::VERSION
  spec.authors     = ["Igor Kasyanchuk"]
  spec.email       = ["igorkasyanchuk@gmail.com"]
  spec.homepage    = "https://github.com/igorkasaynchuk/smart_and_fast_assets"
  spec.summary     = "Summary of SmartAndFastAssets."
  spec.description = "Description of SmartAndFastAssets."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.0.0"
  spec.add_dependency "image_processing"
  spec.add_dependency "fastimage"
  spec.add_dependency "pry"
  spec.add_dependency "sidekiq"
  spec.add_dependency "mini_magick"
  spec.add_dependency "carrierwave"
  spec.add_dependency "webp-ffi"
  spec.add_dependency "open_uri_redirections"

  spec.add_development_dependency "sqlite3"
end
