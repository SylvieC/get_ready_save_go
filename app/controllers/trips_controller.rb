class TripsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @trip = Trip.new
    @trips = Trip.all 
    respond_to do |format|
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


end
