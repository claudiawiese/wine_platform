class AddRecordedAtToPrices < ActiveRecord::Migration[7.1]
  def change
    add_column :prices, :recorded_at, :datetime
  end
end
