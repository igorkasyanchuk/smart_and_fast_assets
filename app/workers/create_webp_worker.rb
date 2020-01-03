class CreateWebpWorker < SmartAssetsWorker

  def perform(url)
    WebpAsset.create_from_url(url)
  end

end
