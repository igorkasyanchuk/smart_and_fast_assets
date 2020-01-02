class AnalyzeImageWorker
  include Sidekiq::Worker

  def perform(type, url)
    case type.to_s
    when 'webp'
      WebpAsset.create_from_url(url)
    else
      SmartAsset.create_from_url(url)
    end
  end

end
