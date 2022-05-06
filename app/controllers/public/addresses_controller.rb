class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @addresses = current_customer.addresses
    @address = Address.new
    @customer = current_customer
  end

  def edit
    @address = Address.find(params[:id])
    @customer = current_customer
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      @customer = current_customer
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

   private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
