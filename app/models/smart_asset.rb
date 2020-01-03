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

require_relative '../workers/smart_asset_worker.rb'

class SmartAsset < ApplicationRecord
  extend SmartAssetUtils

  def SmartAsset.[](url)
    return if url.blank?

    e = SmartAsset.find_by(url: url)
    return e if e

    GeneralWorker.run_job(SmartAssetWorker, url)
  end

  def SmartAsset.create_from_url(url)
    SmartAndFastAssets.log "SmartAsset.create_from_url: #{url}"
    download_url        = final_url(url)
    size                = FastImage.size(download_url)
    raise "Can't detect image size" unless size

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
