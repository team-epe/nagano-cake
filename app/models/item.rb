class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :orders_details
  #has_one_attached :image
  attachment :image
  belongs_to :genre




  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end
