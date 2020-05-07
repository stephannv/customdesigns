class RemoveColumnsFromCustomDesigns < ActiveRecord::Migration[6.0]
  def up
    remove_column :custom_designs, :creator_id
    remove_column :custom_designs, :bookmarks_count
    remove_column :custom_designs, :hearts_count
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
