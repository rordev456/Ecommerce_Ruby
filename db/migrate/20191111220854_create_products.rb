class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :unit_price
      t.integer :stock
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
