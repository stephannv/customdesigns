class CreateCreators < ActiveRecord::Migration[6.0]
  def change
    create_table :creators, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, index: true, type: :uuid
      t.string :name, limit: 10
      t.string :creator_id, limit: 17

      t.timestamps
    end

    add_index :creators, :creator_id, unique: true, where: 'creator_id IS NOT NULL'
  end
end
