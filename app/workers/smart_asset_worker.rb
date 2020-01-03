require_relative '../workers/general_worker.rb'

class SmartAssetWorker
  include Sidekiq::Worker

  def perform(url)
    SmartAsset.create_from_url(url)
  end

end
