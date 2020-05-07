class IncreaseCategoryNameLimit < ActiveRecord::Migration[6.0]
  def up
    change_column :categories, :name, :string, limit: 35
  end

  def down
    change_column :categories, :name, :string, limit: 20
  end
end
