class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page]).per(5)
  end

  def show
    @customer = Customer.find(params[:id])
    @name = @customer.first_name + @customer.last_name
    @name_kana = @customer.first_name_kana + @customer.last_name_kana
  end

  def edit
    @customer = Customer.find(params[:id])
    @name = @customer.first_name + @customer.last_name
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :address, :telephone_number, :email, :is_active)
  end

end
