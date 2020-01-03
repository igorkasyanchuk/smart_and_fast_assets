module WebpImageHelper
  def webp_picture_tag(url, **options)
    ai        = url.blank? ? nil : WebpAsset[url]
    tag.picture do
      if ai.is_a?(WebpAsset)
        concat tag.source "data-srcset": ai.image.url, type: "image/webp", class: 'lazyload'
      end
      concat image_tag(url, **options)
    end
  end

  def image_tag_with_size(url, **options)
    ai = url.blank? ? nil : SmartAsset[url]
    if ai.is_a?(SmartAsset)
      options.symbolize_keys!
      options[:width]  = ai.width
      options[:height] = ai.height
    end
    image_tag url, **options
  end
end