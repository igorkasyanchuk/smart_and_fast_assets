# == Schema Information
#
# Table name: smart_assets
#
#  id         :integer          not null, primary key
#  url        :string
#  width      :integer
#  height     :integer
#  created_at :datetime
#

class SmartAsset < ApplicationRecord
  extend SmartAssetUtils

  def SmartAsset.[](url)
    return if url.blank?

    url = final_url(url)
    sa  = SmartAsset.find_by(url: url)
    return sa if sa

    CreateWebpWorker.run_job(url)
  end

  def SmartAsset.create_from_url(url)
    SmartAndFastAssets.log "SmartAsset.create_from_url: #{url}"
    size                = FastImage.size(url)
    return nil unless size

    asset               = SmartAsset.new
    asset.url           = url
    asset.width         = size[0]
    asset.height        = size[1]
    asset.save
  rescue Exception => ex
    SmartAndFastAssets.log ex.message
    SmartAndFastAssets.log ex.backtrace.take(6).join("\n")
    nil
  end

end
