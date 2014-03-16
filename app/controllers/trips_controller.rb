class TripsController < ApplicationController
  before_filter :authenticate_user!v
  def index
  end
end
