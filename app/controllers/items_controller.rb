class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save 
      flash[:notice] = 'success'
      redirect_to item_path(@item.id)
    else
      render :new
    end  
  end
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = 'success'
      redirect_to item_path(@item.id)
    else
      render :edit
    end  
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end  
  
  private
  def item_params
    params.require(:item).permit(:name, :guide, :image)
  end
  
end

