class Creator < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, on: :update
end
