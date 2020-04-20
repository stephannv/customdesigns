class User < ApplicationRecord
  include Clearance::User

  has_one :creator, dependent: :destroy

  after_create :create_creator

  private

  def create_creator
    create_creator!
  end
end
