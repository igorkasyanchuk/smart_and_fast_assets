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

require_relative '../workers/analyze_image_worker.rb'

class SmartAsset < ApplicationRecord

  def SmartAsset.[](url)
    return if url.blank?

    final_url = SmartAssetUtils.final_url(url)
    sa        = SmartAsset.find_by(url: final_url)
    return sa if sa

    AnalyzeImageWorker.capture_asset_details(final_url)
  end

  def SmartAsset.create_from_url(url)
    puts "SmartAsset.create_from_url: #{url}"
    asset               = SmartAsset.new
    asset.url           = url
    size                = FastImage.size(url)
    return nil unless size
    asset.width         = size[0]
    asset.height        = size[1]
    asset.save
  rescue Exception => ex
    Rails.logger.error(ex.message)
    puts(ex.message)
    puts ex.backtrace.take(10).join("\n")
    nil
  end

end
