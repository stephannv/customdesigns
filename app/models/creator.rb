class Creator < ApplicationRecord
  belongs_to :user

  has_many :custom_designs, dependent: :destroy

  validates :name, presence: true, on: :update
end
