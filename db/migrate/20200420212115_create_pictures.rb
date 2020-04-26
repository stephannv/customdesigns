class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures, id: :uuid do |t|
      t.jsonb :image_data

      t.timestamps
    end
  end
end
