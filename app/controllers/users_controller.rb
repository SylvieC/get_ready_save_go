class UsersController < ApplicationController
  def index
    @users = User.all
 respond_to do |format|
        format.html
        format.json {render json: @users}
      end
  end

  def show
    @user = User.includes(:trips).find(params[:id])
    @users = User.includes(:trips)
    @activity = Activity.new
    @trip = current_user.trips.last

    #activities grouped by theyre category to be displayed at the right place
    @attract_activities = Activity.where(trip_id: @trip.id, category: "attractions") || []
    @restauration_activities = Activity.where(trip_id: @trip.id, category: "restaurants") || []
    @shopping_activities = Activity.where(trip_id: @trip.id, category: "shopping")  || []
    @main_activities = Activity.where(trip_id: @trip.id, category: "")  || []

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

         if @trip.savings.empty?
           @weekly_saving_average = 'None'
         else
           @weekly_saving_average = saved_weekly_average(@trip)
        end

        if @trip.cost.nil?
           @weekly_goal = "Unavailable - trip cost needed"
         else
              @weekly_goal = weekly_saving_goal(@trip)
         end
        gon.data = date_amount_saved(@trip)
        gon.data2 = date_amount_added(@trip)

        # create an activity of category main with two links

        # @activity1 = Activity.create(name: "link_holder", trip_id: @trip.id)
        # @activity1.links.create(title: "lonely planet", category: 'main', content: "http://www.lonelyplanet.com/")


        
    
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
   #  #604,800 seconds make a week
    time_between_first_and_last_savings_in_weeks = (trip.savings.last.created_at.to_f - trip.savings.first.created_at.to_f) / 604800
    answer =  total_saved_for_trip(trip).to_f / time_between_first_and_last_savings_in_weeks
    answer.round(2)
  end

  def weekly_saving_goal(trip)
    time_between_now_and_departure_in_weeks = (DateTime.now.year- trip.start_date.to_f)/ 604800
    amount_left_to_pay = trip.cost - total_saved_for_trip(trip)
    answer =  amount_left_to_pay.to_f / time_between_now_and_departure_in_weeks
    answer.round(2)
  end

  def diff_between_DateTime_objects_in_weeks (date1, date2)
   
  end

end


