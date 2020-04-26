class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)
end
