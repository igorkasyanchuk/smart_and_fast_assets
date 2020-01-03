require "fastimage"
require "sidekiq"
require "webp-ffi"
require "open_uri_redirections"

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

end

# SmartAndFastAssets.setup do |config|
#   config.storage   = :file
#   config.quality   = 85
#   config.execution = :background
#   config.debug     = false
# end

require "active_record"
require "active_model"
require_relative "../app/lib/smart_asset_utils.rb"
require_relative "../app/helpers/webp_image_helper.rb"
require_relative "../app/workers/analyze_image_worker.rb"
require "smart_and_fast_assets/engine"
