
require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :login => "MyString",
      :email => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    rendered.should have_selector("form", :action => users_path, :method => "post") do |form|
      form.should have_selector("input#user_login", :name => "user[login]")
      form.should have_selector("input#user_email", :name => "user[email]")
      form.should have_selector("input#user_password", :name => "user[password]")
      form.should have_selector("input#user_password_confirmation", :name => "user[password]")
    end
  end
end
