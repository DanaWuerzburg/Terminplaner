
require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :login => "MyString",
      :email => "MyString",
      #:active => false,
      #:admin => false,
      :password => "MyString",
      :password_confirmation => "MyString"

    ))
  end

  it "renders the edit user form" do
    render

    rendered.should have_selector("form", :action => user_path(@user), :method => "post") do |form|
      form.should have_selector("input#user_login", :name => "user[login]")
      form.should have_selector("input#user_email", :name => "user[email]")
     # form.should have_selector("input#user_active", :name => "user[active]")
     # form.should have_selector("input#user_admin", :name => "user[admin]")
      form.should have_selector("input#user_password", :name => "user[password]")
      form.should have_selector("input#user_password_confirmation", :name => "user[password]")
    end
  end
end
