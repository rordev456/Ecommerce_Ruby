class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :freight
      t.string :province
      t.string :address
      t.string :postal_code
      t.string :city
      t.timestamp :created
      t.decimal :tax_rate
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
