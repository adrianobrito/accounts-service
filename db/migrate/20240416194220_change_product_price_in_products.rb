class ChangeProductPriceInProducts < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing decimal column
    remove_column :products, :last_product_price, :decimal, precision: 10, scale: 2

    # Add a reference to product_prices
    add_reference :products, :last_product_price, foreign_key: { to_table: :product_prices }
  end
end
