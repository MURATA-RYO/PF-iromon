class CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @items = @Item.page(params[:page]).reverse_order
  end  
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.save(customer_params)
    redirect_to customer_path(@customer.id)
  end
  
  private
  def customer_parms
    params.require(:customer).permit(:name, :email, :password)
  end
end
