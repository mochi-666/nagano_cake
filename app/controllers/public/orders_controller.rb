class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @customer = current_customer
    @order = Order.new
    @address_new = Address.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_id] == "1"
      @order.name = current_customer.first_name + current_customer.last_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    elsif  params[:order][:address_id] == "2"
      if Address.exists?(id: params[:order][:address_select])
        @order.name = Address.find(params[:order][:address_select]).name
        @order.address = Address.find(params[:order][:address_select]).address
        @order.postal_code = Address.find(params[:order][:address_select]).postal_code
      end
    elsif params[:order][:address_id] == "3"
      @address_new = current_customer.addresses.new
      @address_new.postal_code = params[:order][:postal_code]
      @address_new.address = params[:order][:address]
      @address_new.name = params[:order][:address_name]
      @order.name = params[:order][:address_name]
      if @address_new.save
      else
        @customer = current_customer
        render :new
      end
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = "800"
    @total = 0
    @cart_items.each do |cart_item|
    @total += (cart_item.item.price*1.1).floor*cart_item.amount
    @total_payment = @total + @order.postage
    @customer = current_customer
    end
  end

  def complete
    @customer = current_customer
  end

  def create
    @customer = current_customer
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
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path

  end

  def index
    @customer = current_customer
    @orders = current_customer.orders
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @order.postage = "800"
    @total = 0
    @order_items = @order.order_items
    @order_items.each do |order_item|
    @total += (order_item.price*1.1).floor*order_item.amount
    @total_payment = @total + @order.postage
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :postage)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

end
