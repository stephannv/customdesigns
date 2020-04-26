class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :categorizations, dependent: :destroy
  has_many :custom_designs, through: :categorizations

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
