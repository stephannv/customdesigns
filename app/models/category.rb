class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :categorizations, dependent: :destroy
  has_many :custom_designs, through: :categorizations

  validates :name, presence: true
  validates :slug, presence: true

  validates :name, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 35 }

  after_save :generate_custom_designs_full_text_index

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  private

  def generate_custom_designs_full_text_index
    if saved_change_to_name?
      custom_designs.each(&:save)
    end
  end
end
