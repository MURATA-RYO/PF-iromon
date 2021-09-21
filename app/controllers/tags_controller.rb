class TagsController < ApplicationController

  def index
    redirect_to tag_items_path(params[:tag_id])
  end

end
