
require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :login => "Login",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Login".to_s)
    rendered.should contain("Email".to_s)
  end
end
