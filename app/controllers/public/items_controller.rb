class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @item = Item.page(params[:page]).per(4)
    @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end
end
