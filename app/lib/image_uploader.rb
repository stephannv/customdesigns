require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :remove_invalid
  plugin :validation
  plugin :store_dimensions
  plugin :validation_helpers, default_messages: {
    max_dimensions: "must be 1280x720",
    min_dimensions: "must be 1280x720"
  }

  Attacher.validate do
    validate_min_size 1
    validate_max_size 300 * 1024 # 300kb
    validate_extension %w[jpg jpeg png webp tiff tif]
    if validate_mime_type(%w[image/jpeg image/png image/webp image/tiff])
      validate_dimensions [1280..1280, 720..720]
    end
  end

  Attacher.derivatives do |original|
    pipeline = ImageProcessing::MiniMagick.source(original)

    { thumbnail: pipeline.crop!('480x480+400+105') }
  end
end
