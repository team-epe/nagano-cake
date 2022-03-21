class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])

    if @cart_item.present?
      @cart_item.amount += params[:amount].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.save
      redirect_to public_cart_items_path, notice: '商品を追加しました'
    else
      redirect_to request.referer
    end

  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id)
  end

end
