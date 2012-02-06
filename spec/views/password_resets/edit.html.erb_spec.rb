require 'spec_helper'

describe "password_resets/edit" do
  before(:each) do
    @password_reset = assign(:password_reset, stub_model(PasswordReset))
  end

  it "renders the edit password_reset form" do
    render

    rendered.should have_selector("form", :action => password_reset_path(@password_reset), :method => "post") do |form|
    end
  end
end
