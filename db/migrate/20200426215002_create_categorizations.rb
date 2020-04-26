class CreateCategorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :categorizations, id: :uuid do |t|
      t.references :custom_design, null: false, foreign_key: true, type: :uuid
      t.references :category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :categorizations, %i[custom_design_id category_id], unique: true
  end
end
