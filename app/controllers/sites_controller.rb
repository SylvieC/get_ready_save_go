class SitesController < ApplicationController
  def index
    @users = User.all
  end
end
