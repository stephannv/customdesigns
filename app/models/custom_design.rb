class CustomDesign < ApplicationRecord
  belongs_to :creator

  belongs_to :main_picture, class_name: 'Picture', autosave: true
  belongs_to :example_picture, class_name: 'Picture', autosave: true, optional: true

  has_many :categorizations, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :categories, through: :categorizations
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :main_picture
  accepts_nested_attributes_for :example_picture, reject_if: proc { |attributes| attributes[:image].blank? }

  validates :name, presence: true
  validates :design_id, presence: true
  validates :main_picture, presence: true

  validates :design_id, uniqueness: true

  validates :name, length: { maximum: 20 }

  validates :design_id, format: { with: /\AMO(?:-(?:[A-Z]|\d){4}){3}\z/ }

  after_save do
    main_picture.image_derivatives! if main_picture.image_changed?
  end
end
