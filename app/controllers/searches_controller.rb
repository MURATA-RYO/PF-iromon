class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    if @range == '1'
      @customer = Customer.search(search,word)
    else
      @item = Item.search(search,word)
    end
  end
end
