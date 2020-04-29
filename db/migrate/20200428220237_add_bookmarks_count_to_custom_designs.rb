class AddBookmarksCountToCustomDesigns < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_designs, :bookmarks_count, :integer, index: true, default: 0
  end
end
