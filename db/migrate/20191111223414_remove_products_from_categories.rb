class RemoveProductsFromCategories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :categories, :product, null: false, foreign_key: true
  end
end
