class OutfitPhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
