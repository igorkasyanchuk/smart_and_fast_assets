module WebpImageHelper
  EMPTY_PIXEL = "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==".freeze

  def webp_picture_tag(url, **options)
    ai        = url.blank? ? nil : WebpAsset[url]
    tag.picture do
      if ai.is_a?(WebpAsset)
        concat tag.source "data-srcset": ai.image.url, type: "image/webp", class: 'lazyload'
      end
      concat image_tag(url, options)
    end
  end

  def lazy_webp_picture_tag(url, **options)
    options.symbolize_keys! if options.is_a?(Hash)
    options[:class] = [options[:class], "lazyload"].compact.join(" ")
    options["data-src"] = url

    ai = url.blank? ? nil : WebpAsset[url]
    tag.picture do
      if ai.is_a?(WebpAsset)
        concat tag.source "data-srcset": ai.image.url, type: "image/webp", class: 'lazyload'
      end
      concat image_tag(EMPTY_PIXEL, options)
    end
  end

  def image_tag_with_size(url, **options)
    ai = url.blank? ? nil : SmartAsset[url]
    if ai.is_a?(SmartAsset)
      options.symbolize_keys!
      options[:width]  = ai.width
      options[:height] = ai.height
    end
    image_tag url, options
  end
end