class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def comfirm
    @order = Order.new(order_params)
    if params[:order][:address_id] == "1"
      @order.name = current_customer.first_name + current_customer.last_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    elsif  params[:order][:address_id] == "2"
      if Address.exists?(name: params[:order][:registered])
        @order.name = Address.find(params[:order][:registered]).name
        @order.addresd_number = Address.find(params[:order][:registered]).address
      end
    elsif params[:order][:address_id] == "3"
      @address_new = current_customer.orders.new
      @address_new.postal_code = params[:order][:postal_code]
      @address_new.address = params[:order][:address]
      @address_new.name = params[:order][:name]
      if @address_new.save
      else redirect_to new_order_path
      end
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = "800"
    @total = 0
    @cart_items.each do |cart_item|
    @total += (cart_item.item.price*1.1).floor*cart_item.amount
    @total_payment = @total + @order.postage
    end
  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.salesorder = 0
    if @order.save
      @cart_items.each do |cart|
      @order_item = OrderItem.new
      @order_item.item_id = cart.item_id
      @order_item.order_id = @order.id
      @order_item.amount = cart.amount
      @order_item.price = cart.item.price
      @order_item.save
    end
    redirect_to orders_complete_path
    @cart_items.destroy_all
    else
    @order = Order.new(order_params)
    redirect_to :new_order_path
    end
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :postage)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

end
