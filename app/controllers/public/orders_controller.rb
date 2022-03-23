class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order= Order.new
  end

  def create
    @order = current_customer.orders.new(order_params)

    if @order.save
      @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      @cart_items.destroy_all
      redirect_to public_orders_complete_path

    end
  end

  def check
    @order = Order.new(
      customer_id: current_customer.id,
      payment_method: params[:order][:payment_method],
      status: params[:order][:status]
      )


    @order.shipping_cost = 1000
    @cart_items = current_customer.cart_items.all

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address =  Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @adress.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      address_new = current_customer.addresses.new(address_params)
      #if address_new.save

      #else

      #render :new
    #end


    end
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
    @charge = @total + @order.shipping_cost
    @order.total_payment = @charge
    @order.status = 0

  end


  def complete
  end
  
  def index
    @customer = current_customer
    @orders = current_customer.orders
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :status, :shipping_cost,:item_id)
  end

  def address_params
    params.require(:address).permit(:name, :address)
  end


end
