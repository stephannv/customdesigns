class CreateCustomDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_designs, id: :uuid do |t|
      t.references :creator, null: false, foreign_key: true, type: :uuid, index: true
      t.references :main_picture, null: false, foreign_key: { to_table: :pictures }, type: :uuid
      t.references :example_picture, foreign_key: { to_table: :pictures }, type: :uuid
      t.string :name, null: false, limit: 20
      t.string :design_id, null: false, limit: 17

      t.timestamps
    end

    add_index :custom_designs, :design_id, unique: true
  end
end
