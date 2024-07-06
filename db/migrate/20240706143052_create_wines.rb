class CreateWines < ActiveRecord::Migration[7.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :variety
      t.string :region
      t.integer :year

      t.timestamps
    end
  end
end
