class DropCreatorsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :creators
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
