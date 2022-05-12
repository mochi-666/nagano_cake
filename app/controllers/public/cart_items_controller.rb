class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items.all
    @customer = current_customer
  end

  def update
    if @cart_item = CartItem.find(params[:id])
       @cart_item.update(cart_item_params)
       redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      @customer = current_customer
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
   redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
   redirect_to cart_items_path
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       new_amount = @cart_item.amount + params[:cart_item][:amount].to_i
       @cart_item.update(amount: new_amount)
       redirect_to cart_items_path
    else
       @cart_item = CartItem.new(cart_item_params)
       @cart_item.customer_id = current_customer.id
       if @cart_item.save
         @cart_items = current_customer.cart_items.all
         redirect_to cart_items_path
       else
         @cart_items = current_customer.cart_items.all
         @customer = current_customer
         render :index
       end
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
