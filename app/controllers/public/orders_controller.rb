class Public::OrdersController < ApplicationController
  
  def index
    @customer = current_customer
    @orders = current_customer.orders
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @order_details = @order.order_details
<<<<<<< HEAD
  
=======
  end
>>>>>>> refs/remotes/origin/orders_show
  
end
