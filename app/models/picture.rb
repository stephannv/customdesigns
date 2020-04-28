class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :image_data, presence: true
end
