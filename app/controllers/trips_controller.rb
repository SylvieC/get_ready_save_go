class TripsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @trips = Trip.where(user_id: current_user.id)
    @trips.pop
    @data = build_hash_tripid_savingdata(@trips)
      if  @trips.empty?
       #activities grouped by theyre category to be displayed at the right place
        @attract_activities = [] 
        @restauration_activities = []
        @shopping_activities = []
        @hotel_activities = []
        @main_activity=[]

     end

      respond_to do |format|
      format.html
      format.json {render json: @trips}
    end
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
    update_params = params.require(:trip).permit(:from_city, :to_city, :title,:cost, :start_date)
    if update_params[:start_date]
        yyyy = update_params['start_date(1i)'].to_i
        mm = update_params['start_date(2i)'].to_i
        dd = update_params['start_date(3i)'].to_i
        dt = DateTime.new(yyyy,mm,dd)

        update_params[:start_date] = dt
    end
    if update_params[:cost]    
      update_params[:cost] = modify(update_params[:cost]) 
    end  
    @trip.update_attributes(update_params)
    flash[:success]
    redirect_to user_path(current_user.id)
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.delete
    redirect_to user_path(current_user.id)
  end
private

#method to get rid of commas or dollar signs in the input
def isNum?(num)
  /[0-9]/.match(num.to_s) != nil
end

#method to get rid of the commas and dollar sign, I first make the argument cost into a string, 
# then I put it into an array with the split method on '.'  . $4,500.578 would give me [$4,500, 578]
# I iterate over the first element of the array and get rid of all the char that aren't numbers
# for the decimal part, I round the number to 2 decimals and add it to the answer by multiplying it by 0.01
def modify(cost)
   answer = ''
  if cost == cost.to_f || cost == cost.to_i
    return cost
  else 
    cost = cost.to_s
    arr = cost.split('.')
    arr[0].each_char do |c|
      if isNum?(c) 
        answer += c.to_s
      end
    end
  end
  return answer.to_i + arr[1].to_i.round(2)* 0.01
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
    amount_saved = 0
  
    trip.savings.each do |saving|
        hash = {}
        amount_saved += saving.amount
        hash[saving.created_at.strftime("%m-%d-%Y")] = amount_saved
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
   #  #604,800 seconds make a fd
    time_between_first_and_last_savings_in_weeks = (trip.savings.last.created_at.to_i - trip.savings.first.created_at.to_i).to_f/604800
    if time_between_first_and_last_savings_in_weeks <= 1
      return total_saved_for_trip(trip)
    else
        answer =  total_saved_for_trip(trip).to_f / time_between_first_and_last_savings_in_weeks
        return answer.round(2)
    end
  end

  def weekly_saving_goal(trip)
    time_between_now_and_departure_in_weeks = (DateTime.now.to_i- trip.start_date.to_i).to_f/ 604800
    amount_left_to_pay = trip.cost - total_saved_for_trip(trip)
    answer = 0
   if time_between_now_and_departure_in_weeks <= 1  
      return ((amount_left_to_pay/time_between_now_and_departure_in_weeks).round(2)).abs
   else    
      answer =  amount_left_to_pay.to_f/ time_between_now_and_departure_in_weeks
      return (answer.round(2))
    end
  end

  def build_hash_tripid_savingdata(trips)
    # hash will have trip_id as a key and as a value an of hashes with value xvalue of graph and value y value of graph
    result_hash = { }
    trips.each do |trip|
      data = [ ]
      if !trip.savings.nil?
       data << date_amount_saved(trip)
       result_hash[trip.id] = data
      end 
    end
    return result_hash
  end


end
