require 'spec_helper'



describe UsersController do
  
 
   
  describe "GET 'show'" do

    it "returns http success with a signed in user" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      get 'show'
      expect(response).to be_success
    end
  end

end
