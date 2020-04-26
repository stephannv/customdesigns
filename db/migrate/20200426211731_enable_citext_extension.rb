class EnableCitextExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'
  end
end
