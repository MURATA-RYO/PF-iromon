class Admins::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @items = Item.all
    @items = Item.page(params[:page]).reverse_order
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admins_items_path
  end

end
