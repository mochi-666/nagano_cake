class Public::OrdersController < ApplicationController
  def new
    @orde = Order.new
  end

  def comfirm
  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
  end

  def index
  end

  def show
  end
end
