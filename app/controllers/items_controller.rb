class ItemsController < ApplicationController
  
  def new
    @tag_list = Tag.all
    @item = Item.new
    @item = current_customer.items.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id 
    
    # @item = current_customer.items.new(item_params)          
    tag_list = params[:item][:tag_name].split(nil)
    
    if @item.save!
      flash[:notice] = 'successfully'
      # redirect_to item_path(@item.id)
      
      @item.save_tag(tag_list)          
      redirect_to items_path
      
    else
      @customer = current_customer
      @items = Item.all
      render :index
      
      #redirect_back(fallback_location: root_path) 
      
    end  
  end

  def index
    # @tag = Tag.new
    # @tag = Tag.all
    @items = Item.all
    # @item = current_customer.items.new
    
    @items = Item.page(params[:page]).reverse_order
    @item = Item.new
    @customer = current_customer
  end 

  def show
    @item = Item.find(params[:id])
    @customer = @item.customer
    @new = Item.new
    @comment = Comment.new
    
    @tags = @item.tags
    
  end
  
  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @items = @tag.items.all 
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
    params.require(:item).permit(:name, :guide, :image, :tag_name)
  end  
end