require 'spec_helper'

describe "friendships/index" do
  before(:each) do
    assign(:friendships, [
      stub_model(Friendship,
        :user_id => 1,
        :friend_id => 1,
        :status => "Status"
      ),
      stub_model(Friendship,
        :user_id => 1,
        :friend_id => 1,
        :status => "Status"
      )
    ])
  end

  it "renders a list of friendships" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Status".to_s, :count => 2)
  end
end
