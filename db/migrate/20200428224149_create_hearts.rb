class CreateHearts < ActiveRecord::Migration[6.0]
  def change
    create_table :hearts, id: :uuid do |t|
      t.references :creator, null: false, foreign_key: true, type: :uuid
      t.references :custom_design, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :hearts, %i[creator_id custom_design_id], unique: true
  end
end
