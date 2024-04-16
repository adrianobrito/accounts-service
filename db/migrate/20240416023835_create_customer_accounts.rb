class CreateCustomerAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_accounts do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product_price, null: false, foreign_key: true

      t.datetime :created_at
    end
  end
end
