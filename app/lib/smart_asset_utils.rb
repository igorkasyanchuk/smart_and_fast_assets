class SmartAssetUtils

  def SmartAssetUtils.final_url(url)
    return nil if url.blank?

    puts "======== #{url}"

    if url =~ /^http/
      url
    elsif url =~ /base64/
      nil
    else
      tmp = "#{Rails.application.routes.default_url_options[:host]}#{url}"
      tmp = "http://127.0.0.1:3000#{url}"# if Rails.env.development?
      #tmp = "http://#{tmp}" unless tmp =~ /^http/
      tmp
    end
  end

  def SmartAssetUtils.create_tempfile_from(url)
    uri = URI.parse(url)
    puts "create_tempfile_from: #{uri}"
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      file = Tempfile.new(File.basename(url))
      file.binmode
      file.write(resp.body)
      file.flush
      file
    end
  end

end