
require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :login => "Login",
        :email => "Email",
        :current_login_ip => "Current Login Ip",
        :last_login_ip => "Last Login Ip",
        :active => false,
        :admin => false
      ),
      stub_model(User,
        :login => "Login",
        :email => "Email",
        :current_login_ip => "Current Login Ip",
        :last_login_ip => "Last Login Ip",
        :active => false,
        :admin => false
      )
    ])
  end

  it "renders a list of users" do
    render
    rendered.should have_selector("tr>td", :content => "Login".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Email".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Current Login Ip".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Last Login Ip".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
