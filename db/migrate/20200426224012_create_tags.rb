class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name, null: false, limit: 20
      t.citext :slug, null: false

      t.timestamps
    end

    add_index :tags, :name, unique: true
    add_index :tags, :slug, unique: true
  end
end
