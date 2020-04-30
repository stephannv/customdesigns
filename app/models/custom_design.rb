class CustomDesign < ApplicationRecord
  include PgSearch::Model
  # CONFIGS
  pg_search_scope :search_by_everything,
    against: %i[full_text_index],
    using: { tsearch: { tsvector_column: :full_text_index } }

  # RELATIONS
  belongs_to :creator

  belongs_to :main_picture, class_name: 'Picture', autosave: true
  belongs_to :example_picture, class_name: 'Picture', autosave: true, optional: true

  has_many :categorizations, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :hearts, dependent: :destroy

  has_many :categories, through: :categorizations
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :main_picture
  accepts_nested_attributes_for :example_picture, reject_if: proc { |attributes| attributes[:image].blank? }

  # VALIDATIONS
  validates :name, presence: true
  validates :design_id, presence: true
  validates :main_picture, presence: true

  validates :design_id, uniqueness: true

  validates :name, length: { maximum: 20 }

  validates :design_id, format: { with: /\AMO(?:-(?:[A-Z]|\d){4}){3}\z/ }

  # CALLBACKS
  after_save do
    main_picture.image_derivatives! if main_picture.image_changed?
  end

  before_save :generate_full_text_index

  def generate_full_text_index
    return unless new_record? || changed?
    connection = self.class.connection
    sql = <<-SQL
      SELECT
        setweight(to_tsvector('simple', #{connection.quote(name)}), 'A') ||
        setweight(to_tsvector('simple', #{connection.quote(design_id)}), 'A') ||
        setweight(to_tsvector('simple', #{connection.quote(creator.name)}), 'B') ||
        setweight(to_tsvector('simple', #{connection.quote(creator.creator_id)}), 'B') ||
        setweight(to_tsvector('simple', #{connection.quote(categories.map(&:name).join(' '))}), 'B') ||
        setweight(to_tsvector('simple', #{connection.quote(tags.map(&:name).join(' '))}), 'B') AS full_text_index
    SQL

    result = self.class.connection.execute(self.class.sanitize_sql(sql))

    if result.any?
      self.full_text_index = result[0]['full_text_index']
    end
  end
end
