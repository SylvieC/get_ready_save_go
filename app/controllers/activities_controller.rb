class ActivitiesController < ApplicationController
  before_filter :authenticate_user!

def index
  @activities = Activity.all
end

def new
    @activity = Activity.new
    redirect_to user_path(current_user.id)
  end

  def create
    activity = params.require(:activity).permit(:name, :im_url, :category,:trip_id, :comments_attributes => [:content])
    @activity = Activity.create(activity)
    id = current_user.id
    redirect_to user_path(current_user.id)
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    update_params = params.require(:activity).permit(:name, :im_url, :category,:trip_id)
    @activity.update_attributes(update_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.delete
    redirect_to user_path(current_user.id)
  end




end
