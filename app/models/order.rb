class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_details



  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }
  enum status: { waiting: 0, confirmation: 1, making: 2, preparation: 3, shipped: 4 }
  
end

