class AddFullTextIndexToCustomDesigns < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def up
    add_column :custom_designs, :full_text_index, :tsvector
    add_index :custom_designs, :full_text_index, using: :gin, algorithm: :concurrently
  end
end
