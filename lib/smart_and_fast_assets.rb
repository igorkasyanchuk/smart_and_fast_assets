require "fastimage"
require "sidekiq"
require "webp-ffi"
require "open_uri_redirections"

# SmartAndFastAssets.setup do |config|
#   config.storage   = :file
#   config.quality   = 85
#   config.execution = :background
#   config.debug     = false
# end

module SmartAndFastAssets
  mattr_accessor :storage
  @@storage = :file

  mattr_accessor :quality
  @@quality = 80

  mattr_accessor :execution
  @@execution = :background

  mattr_accessor :debug
  @@debug = false

  def self.setup
    yield(self)
  end

  def SmartAndFastAssets.log(message)
    return unless SmartAndFastAssets.debug

    #puts(message)
    Rails.logger.debug(message)
  end

end

require "active_record"
require "active_model"
require_relative "../app/lib/smart_asset_utils.rb"
require_relative "../app/helpers/webp_image_helper.rb"
require_relative "../app/workers/smart_assets_worker.rb"
require_relative "../app/workers/create_webp_worker.rb"
require_relative "../app/workers/analyze_image_worker.rb"
require "smart_and_fast_assets/engine"
