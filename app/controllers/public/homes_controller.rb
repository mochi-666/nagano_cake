class Public::HomesController < ApplicationController
  def top
    @customer = current_customer
    @items = Item.all
    @items = Item.order('id DESC').limit(4)
  end

  def about
    @customer = current_customer
  end
end
