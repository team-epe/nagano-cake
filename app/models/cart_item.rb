class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def subtotal
    item.price * amount
    
  def sum_price
  item.price*amount

  end
end
