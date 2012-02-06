require 'spec_helper'

describe "password_resets/new" do
  before(:each) do
    assign(:password_reset, stub_model(PasswordReset).as_new_record)
  end

  it "renders new password_reset form" do
    render

    rendered.should have_selector("form", :action => password_resets_path, :method => "post") do |form|
    end
  end
end
