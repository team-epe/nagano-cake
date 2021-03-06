class Admin::ItemsController < ApplicationController
  protect_from_forgery

  def index
    @item = Item.all

  end

  def new
    @item=Item.new
    @genre=Genre.all
  end

  def create
    @item=Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path, notice: '商品を削除しました'
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path
    else
      render :edit
    end
  end

private

def item_params
  params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
end

end
