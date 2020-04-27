class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings, id: :uuid do |t|
      t.references :custom_design, null: false, foreign_key: true, type: :uuid
      t.references :tag, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :taggings, %i[custom_design_id tag_id], unique: true
  end
end
