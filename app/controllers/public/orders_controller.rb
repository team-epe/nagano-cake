class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order= Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.quantity
        order_detail.price = cart.item.price
        order_item.save
      end
      redirect_to complete_orders_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end


  end

  def confirm
    @order = Order.new(order_params)
    @cart_products = current_customer.cart_products

    @order.shipping_cost = 1000
    @cart_itrems = current_customer.cart_items

    if params[:order][:address_number] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name
    elsif params[:order][:address_number] == "1"
      @order.postal_code =  Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:address_number] == "2"
      @order.postal_code =  params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    #配送情報がなし
    unless @order.postal_code == "" || @order.address == "" || @order.name == ""
      render :confirm
    #配送情報あり
    else
      @order =Order.new
      @address = current_customer.address
      render :new
    end
  end

  private
  def order_params
      params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :total_payment, :status, :shipping_cost)
  end

  def address_params
  params.require(:order).permit(:name, :address)
  end
end
