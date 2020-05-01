class Creator < ApplicationRecord
  belongs_to :user

  has_many :custom_designs, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :hearts, dependent: :destroy

  has_many :bookmarked_custom_designs, through: :bookmarks, source: :custom_design
  has_many :loved_custom_designs, through: :hearts, source: :custom_design

  validates :name, presence: true, on: :update
  validates :permanlink, presence: true, on: :update

  validates :permanlink, length: { maximum: 20 }
  validates :island_name, length: { maximum: 10 }
  validates :twitter_username, length: { maximum: 15 }

  validates :permanlink, format: { with: /\A^[a-zA-Z0-9_]*\z/ }, allow_blank: true
  validates :creator_id, format: { with: /\AMA(?:-(?:\d){4}){3}\z/ }, allow_blank: true
  validates :twitter_username, format: { with: /\A^[a-zA-Z0-9_]*\z/ }, allow_blank: true
  validates :friend_code, format: { with: /\ASW(?:-(?:\d){4}){3}\z/ }, allow_blank: true
  validates :island_name, format: { with: /\A^[a-zA-Z0-9_ ]*\z/ }, allow_blank: true

  def bookmarked?(custom_design)
    bookmarked_custom_designs.exists?(id: custom_design.id)
  end

  def loved?(custom_design)
    loved_custom_designs.exists?(id: custom_design.id)
  end

  def to_param
    permanlink
  end
end
