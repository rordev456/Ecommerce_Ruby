class AddSizeToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :size, :integer
  end
end
