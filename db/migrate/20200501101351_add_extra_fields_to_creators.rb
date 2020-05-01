class AddExtraFieldsToCreators < ActiveRecord::Migration[6.0]
  def change
    add_column :creators, :permanlink, :citext
    add_column :creators, :island_name, :string, limit: 20
    add_column :creators, :friend_code, :string, limit: 17
    add_column :creators, :twitter_username, :string, limit: 15

    add_index :creators, :permanlink, unique: true
  end
end
