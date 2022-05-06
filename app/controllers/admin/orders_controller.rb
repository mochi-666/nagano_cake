class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order.postage = "800"
    @total = 0
    @order_items = @order.order_items
    @order_items.each do |order_item|
    @total += (order_item.price*1.1).floor*order_item.amount
    @total_payment = @total + @order.postage
    end
  end
end
