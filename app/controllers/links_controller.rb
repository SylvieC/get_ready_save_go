class LinksController < ApplicationController
    before_filter :authenticate_user!

   def index
    @links = Link.all 
   end

  def new
    @link = Link.new
    redirect_to user_path(current_user.id)
  end

  def create
    link = params.require(:link).permit(:title, :type, :content, :cost, :activity_id)
    @link = Link.create(link)
    redirect_to user_path(current_user.id)
  end
 
  
  def edit
    @link = Link.find(params(:id))
  end

  def update
    @link = Link.find(params[:id])
    update_params = params.require(:link).permit(:type, :content, :cost, :activity_id) 
    @link.update_attributes(update_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    link= Link.find(params[:id])
    link.delete
    redirect_to user_path(current_user.id)
  end
end
