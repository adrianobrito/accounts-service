class CreateProductPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :product_prices do |t|
      t.decimal :product_price, precision: 10, scale: 2

      t.datetime :created_at
    end
  end
end
