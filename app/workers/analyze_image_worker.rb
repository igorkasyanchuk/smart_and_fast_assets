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

  def AnalyzeImageWorker.create_webp(url)
    AnalyzeImageWorker.run_job(:webp, url)
  end

  def AnalyzeImageWorker.capture_asset_details(url)
    AnalyzeImageWorker.run_job(:smart, url)
  end

  private

  def AnalyzeImageWorker.run_job(type, url)
    case SmartAndFastAssets.execution
    when :inline
      AnalyzeImageWorker.new.perform(type, url)
    when :background
      AnalyzeImageWorker.perform_async(type, url)
    else
      raise 'incorrect value'
    end
  end

end
