class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @savings = Saving.all
    @saving = Saving.create(new_saving)
    respond_to do |format|
      format.html
      format.json { render json: @saving}
    end
  end

  def new
    @saving = Saving.new
  end

  def create
    new_saving = params.require(:saving).permit(:amount, :trip_id)
    #method to get rid of commas and dollar signs if the user has used any
    if params[:saving][:amount] != nil
      params[:saving][:amount] = modify(params[:saving][:amount])
      @saving = Saving.create(new_saving)
    else
      flash[:error]
    end
    redirect_to user_path(current_user.id)
  end

  def destroy
     saving = Saving.find(params[:id])
     saving.delete
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

