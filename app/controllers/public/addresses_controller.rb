class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer
    @address = Address.new
  end

  def edit
    @address = current_customer
  end

  def create
    @address = current_customer
    @address.update(address_params)
    redirect_to addresses_path
  end

  def update
    @address = current_customer
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = current_customer
    @address.destroy
    redirect_to address_path
  end

   private

  def customer_params
    params.require(:adress).permit(:telephone_number, :address, :name)
  end

end
