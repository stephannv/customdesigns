class DropBookmarksTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :bookmarks
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
