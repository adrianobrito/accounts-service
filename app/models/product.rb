class Product < ApplicationRecord
  belongs_to :last_product_price, class_name: 'ProductPrice', foreign_key: 'last_product_price_id', optional: true 

  def last_product_price_value
    self.last_product_price&.product_price
  end
end
