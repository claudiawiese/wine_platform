class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.references :wine, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
