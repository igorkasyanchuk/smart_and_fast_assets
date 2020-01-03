# == Schema Information
#
# Table name: webp_assets
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

require_relative '../workers/create_webp_worker.rb'

class WebpAsset < ApplicationRecord
  extend SmartAssetUtils

  mount_uploader :image, SmartPhotoUploader

  def WebpAsset.[](url)
    return if url.blank?

    e = WebpAsset.find_by(url: url)
    return e if e

    GeneralWorker.run_job(CreateWebpWorker, url)
  end

  def WebpAsset.create_from_url(url)
    SmartAndFastAssets.log "WebpAsset.create_from_url: #{url}"
    download_url = final_url(url)

    tf = Tempfile.new
    tf.binmode
    tf.write(open(download_url, allow_redirections: :all).read)
    tf.flush

    wp_path = tf.path + ".webp"

    ::WebP.encode(tf.path, wp_path, { quality: SmartAndFastAssets.quality })

    original_size = File.size(tf.path)
    new_size      = File.size(wp_path)

    SmartAndFastAssets.log "================================================================="
    SmartAndFastAssets.log "Original: #{original_size}, NEW: #{new_size}, Quality: #{SmartAndFastAssets.quality}%, Optimization: #{ 100 - 100 * (new_size / original_size.to_f).round(2) }%"
    SmartAndFastAssets.log "================================================================="

    size                = FastImage.size(tf.path)
    raise "Can't detect image size" unless size

    asset               = WebpAsset.new
    asset.url           = url
    asset.image         = File.open(wp_path)
    asset.original_size = original_size
    asset.new_size      = new_size
    asset.width         = size[0]
    asset.height        = size[1]
    asset.save
  rescue Exception => ex
    SmartAndFastAssets.log ex.message
    SmartAndFastAssets.log ex.backtrace.take(6).join("\n")
    nil
  ensure
    tf&.unlink
  end

end
