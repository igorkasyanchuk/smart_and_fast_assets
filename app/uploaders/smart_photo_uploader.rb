class SmartPhotoUploader < CarrierWave::Uploader::Base
  storage SmartAndFastAssets.storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
