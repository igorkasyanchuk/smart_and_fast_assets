class AnalyzeImageWorker < SmartAssetsWorker

  def perform(url)
    SmartAsset.create_from_url(url)
  end

end
