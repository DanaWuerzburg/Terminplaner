
require 'spec_helper'

describe "friendship_appointments/index" do
  before(:each) do
    assign(:friendship_appointments, [
      stub_model(FriendshipAppointment,
        :user_id => 1,
        :friend_id => 1,
        :appointment_id => 1,
        :shared_friend_id => 1
      ),
      stub_model(FriendshipAppointment,
        :user_id => 1,
        :friend_id => 1,
        :appointment_id => 1,
        :shared_friend_id => 1
      )
    ])
  end

  it "renders a list of friendship_appointments" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
