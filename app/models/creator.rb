class Creator < ApplicationRecord
  has_many :custom_designs, dependent: :destroy

  validates :name, presence: true, on: :update
  validates :creator_id, presence: true, on: :update

  validates :name, length: { maximum: 20 }

  validates :creator_id, format: { with: /\AMA(?:-(?:\d){4}){3}\z/ }, allow_blank: true

  after_save :generate_custom_designs_full_text_index

  def to_param
    creator_id
  end

  private

  def generate_custom_designs_full_text_index
    if saved_change_to_name? or saved_change_to_creator_id?
      custom_designs.each(&:save)
    end
  end
end
