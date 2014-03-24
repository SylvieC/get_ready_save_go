class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @trip = current_user.trips.last 
    gon.beg = @trip.from_city || "San Francisco"
    gon.finish = @trip.to_city || "Paris, France"

        if @trip.cost.nil? 
          gon.ratio = 1
        elsif @trip.cost == 0
          gon.ratio = 0
        else
          gon.ratio = total_saved_for_trip(@trip).to_f/@trip.cost 
        end 

        gon.percentage_saved = gon.ratio * 100
        gon.total_saved = total_saved_for_trip(@trip)
        gon.trip_cost =  @trip.cost
        gon.data = date_amount_saved(@trip)
        gon.data2 = date_amount_added(@trip)
    
    #the distance to the middle marker will be gon.ratio * line_length
  end


  private


  def total_saved_for_trip(trip)
    total = 0
    if  trip.savings != []
      trip.savings.each {|saving| total += saving.amount }
    end
      return total.to_f

  end

  def reach_goal?(trip)
    total_saved(trip)>= trip.cost
  end

  def date_amount_saved(trip)
    
    new_array = []
    new_array << {label:'start', y:0}
    amount_saved = 0
  
    trip.savings.each do |saving|
        hash = {}
         hash['label'] =  saving.created_at.strftime("%m-%d-%Y")
        amount_saved += saving.amount
        hash['y'] = amount_saved 
        new_array << hash
     end
    return new_array
  end

  def date_amount_added(trip)
    new_array = []
    trip.savings.each do |saving|
        hash = {}
         hash['label'] =  saving.created_at.strftime("%m-%d-%Y")
        hash['y'] = saving.amount
        new_array << hash
     end
    return new_array
  end

end
