class Tagging < ApplicationRecord
  belongs_to :custom_design
  belongs_to :tag

  validates :tag_id, presence: true

  validates :tag_id, uniqueness: { scope: :custom_design_id }
end
