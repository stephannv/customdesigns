class Tag < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :slug, presence: true

  validates :name, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 20 }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
