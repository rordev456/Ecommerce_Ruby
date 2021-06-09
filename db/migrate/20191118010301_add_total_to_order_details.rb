class AddTotalToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :total, :decimal
  end
end
