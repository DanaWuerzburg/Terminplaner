require 'spec_helper'

describe "user_sessions/new" do
  before(:each) do
    assign(:user_session, stub_model(UserSession).as_new_record)
  end

  it "renders new user_session form" do
    render

    rendered.should have_selector("form", :action => user_sessions_path, :method => "post") do |form|
    end
  end
end
