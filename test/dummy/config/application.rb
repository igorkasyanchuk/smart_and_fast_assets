require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "smart_and_fast_assets"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.hosts << "storyteller.storyteller.com"
    config.hosts << "site.com"
    config.hosts << "127.0.0.1"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

