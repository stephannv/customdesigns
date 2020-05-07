class DropHeartsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :hearts
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
