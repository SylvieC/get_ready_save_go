class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    trip = current_user.trips.last
    gon.beg = trip.from_city || "san francisco"
    gon.finish = trip.to_city || "paris, France"
  end
end
