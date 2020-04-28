class Bookmark < ApplicationRecord
  belongs_to :creator
  belongs_to :custom_design, counter_cache: true

  validates :creator_id, presence: true
  validates :custom_design_id, presence: true

  validates :custom_design_id, uniqueness: { scope: :creator_id }
end
