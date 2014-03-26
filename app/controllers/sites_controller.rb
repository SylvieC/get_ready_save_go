class SitesController < ApplicationController
  def index
    @users = User.all
    @name = "Sylvie"
  end
end
