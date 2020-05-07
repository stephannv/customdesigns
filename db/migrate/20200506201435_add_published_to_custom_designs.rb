class AddPublishedToCustomDesigns < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_designs, :published, :boolean, default: false
    add_index :custom_designs, :published
  end
end
