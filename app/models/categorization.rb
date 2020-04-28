class Categorization < ApplicationRecord
  belongs_to :custom_design
  belongs_to :category

  validates :category_id, presence: true

  validates :category_id, uniqueness: { scope: :custom_design_id }
end
