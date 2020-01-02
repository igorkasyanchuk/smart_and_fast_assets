# == Schema Information
#
# Table name: webp_assets
#
#  id         :integer          not null, primary key
#  url        :string
#  width      :integer
#  height     :integer
#  created_at :datetime
#

class WebpAsset < ApplicationRecord
  mount_uploader :image, SmartPhotoUploader

  def WebpAsset.[](url)
    return if url.blank?

    url = SmartAssetUtils.final_url(url)
    sa  = WebpAsset.find_by(url: url)
    return sa if sa

    case SmartAndFastAssets.execution
    when :inline
      AnalyzeImageWorker.new.perform(:webp, url)
    when :background
      AnalyzeImageWorker.perform_async(:webp, url)
    else
      raise 'incorrect value'
    end
  end

  def WebpAsset.create_from_url(url)
    tf      = SmartAssetUtils.create_tempfile_from(url)
    wp_path = tf.path + ".webp"

    ::WebP.encode(tf.path, wp_path, { quality: SmartAndFastAssets.quality })

    original_size = File.size(tf.path)
    new_size      = File.size(wp_path)

    puts "========================================================="
    puts "Original: #{original_size}, NEW: #{new_size}, Quality: #{SmartAndFastAssets.quality}, Optimization: #{ 100 - (new_size / original_size.to_f).round(2) }%"
    puts "========================================================="

    asset               = WebpAsset.new
    asset.url           = url
    asset.image         = File.open(wp_path)
    size                = FastImage.size(tf.path)
    asset.width         = size[0]
    asset.height        = size[1]
    asset.original_size = original_size
    asset.new_size      = new_size
    asset.save
  rescue Exception => ex
    Rails.logger.error ex.message
    puts ex.message
    puts ex.stacktrace.join("\n")
    nil
  ensure
    tf&.unlink
  end

end
