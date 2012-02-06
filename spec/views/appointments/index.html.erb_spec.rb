require 'spec_helper'

describe "appointments/index" do
  before(:each) do
    assign(:appointments, [
      stub_model(Appointment,
        :note => "Note",
        :priority_number => 1,
        :group => "Group",
        :user_id => 1,
        :group_id => 1,
        :color => "Color",
        :name => "Name"
      ),
      stub_model(Appointment,
        :note => "Note",
        :priority_number => 1,
        :group => "Group",
        :user_id => 1,
        :group_id => 1,
        :color => "Color",
        :name => "Name"
      )
    ])
  end

  it "renders a list of appointments" do
    render
    rendered.should have_selector("tr>td", :content => "Note".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Group".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Color".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
