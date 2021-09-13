class FavoritesController < ApplicationController

  before_action :authenticate_customer!
  
def create
  @item = Item.find(params[:item_id])
  favorite = current_customer.favorites.new(item_id: @item.id)
  favorite.save
  redirect_back(fallback_location: root_path)
end

def destroy
  @item = Item.find(params[:item_id])
  favorite = current_customer.favorites.find_by(item_id: @item.id)
  favorite.destroy
  redirect_back(fallback_location: root_path)
end

end
