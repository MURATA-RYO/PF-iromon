class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id 
    if @item.save
      flash[:notice] = 'successfully'
      redirect_to item_path(@item.id)
    else
      @customer = current_customer
      @items = Item.all
      render :index
    end  
  end

  def index
    @items = Item.all
    @item = Item.new
    @customer = current_customer
  end 

  def show
    @item = Item.find(params[:id])
    @customer = @item.customer
    @new = Item.new
    @item_comment = Comment.new
  end
  
  def edit
    @item = Item.find(params[:id])
    unless @item.customer == current_customer
      redirect_to items_path
    end  
  end 
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'successfully'
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end 
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :guide, :image_id)
  end  
end