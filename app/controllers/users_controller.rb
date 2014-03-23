class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @trip = current_user.trips.last
    gon.beg = @trip.from_city || "San Francisco"
    gon.finish = @trip.to_city || "Paris, France"
    if  @trip.cost != nil && (total_saved_for_trip(@trip) != 0)
      gon.ratio = @trip.cost.to_f / total_saved_for_trip(@trip) 
    else 
      gon.ratio = 1
    end
    gon.name= 'Phnom Penh, Cambodia'
    gon.data = date_amount_saved(@trip)
    
    #the distance to the middle marker will be gon.ratio * line_length
  end

  private

  def total_saved_for_trip(trip)
    total = 0
    trip.savings.each {|saving| total += saving.amount }
    return total.to_f
  end

  def reach_goal?(trip)
    total_saved(trip)>= trip.cost
  end

  def date_amount_saved(trip)
    xcoord = [0]
    ycoord = [0]
    new_array = [{0 => 0}]
    trip.savings.each do |saving|
        hash = {}
        hash["label"] =  saving.created_at.strftime("%m-%d %Y")
        hash['y'] = saving.amount
        new_array << hash
       end
    return new_array
  end
end
