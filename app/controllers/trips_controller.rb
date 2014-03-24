class TripsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @trip = Trip.new
    @trips = Trip.all 
  end

  def new
    @trip = Trip.new
    redirect_to user_path(current_user.id)
  end

  def create
    trip = params.require(:trip).permit(:from_city, :to_city, :title,:cost,:start_date)
    @trip = Trip.new(trip)
    @trip.user_id = current_user.id
    @trip.save
    id = current_user.id
    redirect_to user_path(current_user.id)
  end
  
  def edit
    @trip = Trip.find(params(:id))
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update_attributes(params.require(:trip).permit(:from_city, :to_city, :title,:cost,:start_date))
    redirect_to user_path(current_user.id)
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.delete
    redirect_to user_path(current_user.id)
  end



end
