class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    drop_table :carts

    create_table :carts do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
