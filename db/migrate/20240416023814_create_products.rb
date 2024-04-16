class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :last_product_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
