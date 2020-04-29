class AddHeartsCountToCustomDesigns < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_designs, :hearts_count, :integer, index: true, default: 0
  end
end
