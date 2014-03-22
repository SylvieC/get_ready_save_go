class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @savings = Saving.all
  end

  def new
    @saving = Saving.new
  end

  def create
    new_saving = params.require(:saving).permit(:amount, :trip_id)
    @saving = Saving.create(new_saving)
    respond to do |format|
      format.json { render json: @saving}
    end
  end
end
