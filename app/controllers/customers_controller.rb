class CustomersController < ApplicationController

  def index
    @customers = Customer.all
    @customer = current_customer
    @item = Item.new
  end
  
  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
    @item = Item.new
  end  
  
  def edit
    @customer = Customer.find(params[:id])
    unless @customer.id == current_customer.id
      redirect_to customer_path(current_customer)
    end  
  end  
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = 'successfully'
      redirect_to customer_path(@customer)
    else
      render :edit
    end  
  end
  
    private
  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, :image)
  end  
end