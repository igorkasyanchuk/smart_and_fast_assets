require "smart_and_fast_assets/engine"
require "fastimage"

module SmartAndFastAssets

  mattr_accessor :storage
  @@storage = :file

  mattr_accessor :quality
  @@quality = 80

  mattr_accessor :execution
  @@execution = :background

  def self.setup
    yield(self)
  end

end

# SmartAndFastAssets.setup do |config|
#   config.storage   = :file
#   config.quality   = 85
#   config.execution = :background
# end