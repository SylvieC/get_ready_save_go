class UsersController < ApplicationController
  def index
    @users = User.all
 respond_to do |format|
        format.html
        format.json {render json: @users}
      end
  end

  def show
    @user = User.find(params[:id])
    @trip = current_user.trips.last 
    if @trip.nil?
      @trip = Trip.create(from_city: "San Francisco", to_city: "Paris, France")
    end
    gon.beg = @trip.from_city 
    gon.finish = @trip.to_city 

          
        if @trip.cost == 0
           gon.ratio == 0
        elsif @trip.cost.nil? 
          gon.ratio = 2
        else
          gon.ratio = total_saved_for_trip(@trip).to_f/@trip.cost 
        end 

        gon.percentage_saved = gon.ratio.round(2) * 100
        gon.total_saved = total_saved_for_trip(@trip)
        @total_saved = total_saved_for_trip(@trip)
        # @weekly_saving_average = saved_weekly_average(@trip)
        # @weekly_goal = weekly_saving_goal(@trip)
        gon.trip_cost =  @trip.cost
        gon.data = date_amount_saved(@trip)
        gon.data2 = date_amount_added(@trip)
    
        respond_to do |format|
          format.html
          format.json {render json: @user}
         end 
    
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

  def saved_weekly_average(trip)
    #604,800 seconds make a week
   #  time_between_first_and_last_savings_in_weeks = (trip.savings.last.created_at - trip.savings.first.created_at) / 604800

   # return total_saved_for_trip(trip).to_f / time_between_first_and_last_savings_in_weeks
  end

  def weekly_saving_goal(trip)
    # time_between_now_and_departure_in_weeks = (DateTime.now - trip.start_date)/ 604800
    # amount_left_to_pay = trip.cost - total_saved_for_trip(trip)
    # return amount_left_to_pay.to_f / time_between_now_and_departure_in_weeks
  end

end
