class Admin::CustomersController < ApplicationController
  def index
    @customers=Customer.all
  end
  def show
    @customers = Customer.find(params[:id])
  end

  def edit
    @customers = Customer.find(params[:id])
  end

  def update
    @customers = Customer.find(params[:id])
    if @customers.update(customer_params)
      redirect_to admin_customer_path(@customers)
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
end