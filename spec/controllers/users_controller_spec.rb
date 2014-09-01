          require 'spec_helper'



describe UsersController do
  
 
   
  describe "GET 'show'" do
    it "assigns the requested user to @user" do
    user = FactoryGirl.create(:user)

    sign_in(user)
    attrib = FactoryGirl.attributes_for(:trip)
    user.trips.create(attrib)
    get :show, id: user
    expect(response).to be_success
    end 
  end
 
  describe "GET 'index" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      get 'index'
      expect(response).to be_success
    end
  end




end



