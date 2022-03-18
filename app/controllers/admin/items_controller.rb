class Admin::ItemsController < ApplicationController

  
  def index
    @items=Items.all
  end

  def new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

end
