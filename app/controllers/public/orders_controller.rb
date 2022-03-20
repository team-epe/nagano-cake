class Public::OrdersController < ApplicationController
  def new
    @order= Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  def confirm
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif params[:order][:address_select] == "1"
      @order.postal_code =  ShipAddress.find(params[:order][:address_id]).postal_code
      @order.address = ShipAddress.find(params[:order][:address_id]).address
      @order.name = ShipAddress.find(params[:order][:address_id]).name
    elsif params[:order][:address_select] == "2"
      @order.postal_code =  params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    unless @order.postal_code == "" || @order.address == "" || @order.name == ""
      render :confirm

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
end
