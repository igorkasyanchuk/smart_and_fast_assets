require_relative '../workers/general_worker.rb'

class CreateWebpWorker
  include Sidekiq::Worker

  def perform(url)
    WebpAsset.create_from_url(url)
  end

end
