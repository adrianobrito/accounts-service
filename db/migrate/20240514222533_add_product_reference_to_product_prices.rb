class AddProductReferenceToProductPrices < ActiveRecord::Migration[7.1]
  def change
    add_column :product_prices, :product_id, :integer
  end
end
