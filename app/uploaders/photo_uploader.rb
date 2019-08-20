class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process eager: true
  process convert: 'jpg'
end
