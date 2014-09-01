          require 'spec_helper'



describe UsersController do
  
 
   
  describe "GET #show'" do
    it "assigns the requested user to @user" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    get :show, id: user
    expect(response).to be_success

end

    # it "returns http success with a signed in user" do
    #   user = FactoryGirl.create(:user)
    #   sign_in(user)
    #   get "users\/#{user.id}"
    #   expect(response).to be_success
    # end
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



