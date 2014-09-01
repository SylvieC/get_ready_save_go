
require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.create(:user).should be_valid
  end

  it 'is invalid without a password' do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it 'has confirmed password' do
    FactoryGirl.build(:user, password_confirmation: 'foobarbar').should be_valid
  end

  it "duplicate emails are invalid" do
  FactoryGirl.create(:user, email: 'bob@gmail.com')
  user = User.new(email: 'bob@gmail.com')
  expect(user).to have(1).errors_on(:email)
end

end

