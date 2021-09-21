class Admins::CustomersController < ApplicationController
  
  # def new
    # @customer = Customer.new
  # end  
  
  def index
    @customers = Customer.all
  end   
   
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admins_customers_path(id: current_admin)
  end  

end


