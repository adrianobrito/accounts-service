class CustomerAccount < ApplicationRecord
  belongs_to :customer
  belongs_to :product_price
end
