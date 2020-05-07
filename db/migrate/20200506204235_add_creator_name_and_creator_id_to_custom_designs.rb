class AddCreatorNameAndCreatorIdToCustomDesigns < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_designs, :creator_name, :string, limit: 10, null: false
    add_column :custom_designs, :creator_id, :string, limit: 17, null: false
    add_index :custom_designs, :creator_id
  end
end
