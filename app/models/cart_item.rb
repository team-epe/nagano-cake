class CartItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def sum_price
  item.price*amount
  end
end
