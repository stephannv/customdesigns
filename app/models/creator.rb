class Creator < ApplicationRecord
  belongs_to :user

  has_many :custom_designs, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true, on: :update

  validates :creator_id, format: { with: /\AMA(?:-(?:\d){4}){3}\z/ }, allow_blank: true

  def bookmarked?(custom_design)
    bookmarks.find_by(custom_design_id: custom_design.id).present?
  end
end
