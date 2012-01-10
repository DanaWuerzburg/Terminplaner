require 'test_helper'

class UserSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  describe "the signup process", :type => :request do
    before :each do
      User.make(:lgoin => 'username', :password => 'password')
    end

    it "signs me in" do
      within("#usersession") do
        fill_in 'Login', :with => 'username'
        fill_in 'Password', :with => 'password'
      end
      click_link 'Sign in'
    end
  end
end
