class TripsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @trip = Trip.new
    @trips = Trip.all |
  end

  def new
  end

  def create
    trip = params.require(:trip).permit(:from_city, :to_city, :title)
    @trip = Trip.new(trip)
    @trip.user_id = current_user.id
    @trip.save
    redirect_to  user_trip_path(current_user.id)
  end

  def update
  end
 end
