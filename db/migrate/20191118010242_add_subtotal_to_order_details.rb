class AddSubtotalToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :subtotal, :decimal
  end
end
