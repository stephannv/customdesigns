class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :categorizations, dependent: :destroy
  has_many :custom_designs, through: :categorizations

  validates :name, presence: true
  validates :slug, presence: true

  validates :name, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 20 }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
