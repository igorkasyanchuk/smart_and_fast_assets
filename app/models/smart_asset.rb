# == Schema Information
#
# Table name: smart_assets
#
#  id            :integer          not null, primary key
#  url           :string
#  width         :integer
#  height        :integer
#  original_size :integer
#  new_size      :integer
#  image         :string
#  created_at    :datetime
#

class SmartAsset < ApplicationRecord

  def SmartAsset.[](url)
    return if url.blank?

    url = SmartAssetUtils.final_url(url)
    sa  = SmartAsset.find_by(url: url)
    return sa if sa

    case SmartAndFastAssets.execution
    when :inline
      AnalyzeImageWorker.new.perform(:smart, url)
    when :background
      AnalyzeImageWorker.perform_async(:smart, url)
    else
      raise 'incorrect value'
    end
  end

  def SmartAsset.create_from_url(url)
    asset               = SmartAsset.new
    asset.url           = url
    size                = FastImage.size(url)
    asset.width         = size[0]
    asset.height        = size[1]
    asset.save
  rescue Exception => ex
    Rails.logger.error(puts(ex.message))
    nil
  end

end
