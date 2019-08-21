class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process eager: true
  process convert: 'jpg'

  version :thumbnail do
    eager
    resize_to_fill(50, 50)
  end
end
