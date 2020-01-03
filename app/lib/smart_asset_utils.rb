module SmartAssetUtils

  def final_url(url)
    return nil if url.blank?

    SmartAndFastAssets.log "======== #{url}"

    if url =~ /^http/
      url
    elsif url =~ /base64/
      nil
    else
      tmp = "#{Rails.application.routes.default_url_options[:host]}#{url}"
      tmp = "http://127.0.0.1:3000#{url}" if Rails.env.development?
      tmp = "http://#{tmp}" unless tmp =~ /^http/
      tmp
    end
  end

end